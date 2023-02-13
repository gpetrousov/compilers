/* Symbolic table functions file */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

/* current scope */
int cur_scope = 0;
int declare;

void init_hash_table() {
	int i; 
	hash_table = malloc(SIZE * sizeof(list_t*));
	for (i = 0; i < SIZE; i++) hash_table[i] = NULL;
}

unsigned int hash(char *key) {
	unsigned int hashval = 0;
	for(;*key!='\0';key++) hashval += *key;
	hashval += key[0] % 11 + (key[0] << 3) - key[0];
	return hashval % SIZE;
}

void insert(char *name, int len, int type, int lineno) {
	unsigned int hashval = hash(name);
	list_t *l = hash_table[hashval];
	
	while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
	
	/* variable not yet in table */
	if (l == NULL) {
		/* Check if we are really declaring */
		if ( declare == 1 ) {
			l = (list_t*) malloc(sizeof(list_t));
			strncpy(l->st_name, name, len);
			/* add to hashtable */
			l->st_type = type;
			l->scope = cur_scope;
			l->lines = (reflist*) malloc(sizeof(reflist));
			l->lines->lineno = lineno;
			l->lines->next = NULL;
			l->next = hash_table[hashval];
			hash_table[hashval] = l;
			printf("Inserted %s for the first time with linenumber: %d and hashvalue: %d!\n", name, lineno, hashval);
		}
		else {
			/* add it to check it again later */
			l = (list_t*) malloc(sizeof(list_t));
			strncpy(l->st_name, name, len);
			l->st_type = type;
			l->scope = cur_scope;
			l->lines = (reflist*) malloc(sizeof(reflist));
			l->lines->lineno = lineno;
			l->lines->next = NULL;
			l->next = hash_table[hashval];
			hash_table[hashval] = l;
			printf("Inserted %s at line %d to check it again later!\n", name, lineno);

			/* Adding identifier to the revisit queue! */
			//add_to_queue(l->st_name, PARAM_CHECK);
		}
	}

	/* found in table */
	else {
		if (declare == 0) {
			/* If we reference the variable on another line. */
			reflist *t = l->lines;

			// Looks for the next empty line
			while (t->next != NULL) t = t->next;
			/* add line number to reference list */
			t->next = (reflist*) malloc(sizeof(reflist));
			t->next->lineno = lineno;
			t->next->next = NULL;
			printf("Found %s again at line %d!\n", name, lineno);
		}
		else {
			/* If we declare the variable in the same scope with the same name. */
			if (l->scope == cur_scope) {
				fprintf(stderr, "Multiple declaration of variable %s at line %d\n", name, lineno);
				exit(1);
			}
			else {
				/* other scope - create new entry - we reference a global variable */
				l = (list_t*) malloc(sizeof(list_t));
				strncpy(l->st_name, name, len);  
				/* add to hashtable */
				l->st_type = type;
				l->scope = cur_scope;
				l->lines = (reflist*) malloc(sizeof(reflist));
				l->lines->lineno = lineno;
				l->lines->next = NULL;
				l->next = hash_table[hashval];
				hash_table[hashval] = l; 
				printf("Inserted %s for a new scope with linenumber %d and hashvalue: %d!\n", name, lineno, hashval);
			}
		}
	}
}

/* return symbol if found or NULL if not found */
list_t *lookup(char *name){
    unsigned int hashval = hash(name);
    list_t *l = hash_table[hashval];
    while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
    return l;
}

/* return symbol if found or NULL if not found */
list_t *lookup_scope(char *name, int scope) {
    unsigned int hashval = hash(name);
    list_t *l = hash_table[hashval];
    while ((l != NULL) && (strcmp(name,l->st_name) != 0) && (scope != l->scope)) l = l->next;
    return l;
}

/* Remove items from the same scope and decrease the scope variable. */
void hide_scope() {
	list_t *l;
	int i;
	printf("Hiding scope \'%d\':\n", cur_scope);
	for (i = 0; i < SIZE; i++) {
		if (hash_table[i] != NULL) {
			l = hash_table[i];

			/* Find the first item that is from the same scope, before decreasing it */
			while (l != NULL && l->scope == cur_scope) {
				printf("Hiding %s..\n", l->st_name);
				l = l->next;
			}
			/* Set the list equal to that item */
			hash_table[i] = l;
		}
	}
	cur_scope--;
}

/* Increase current scope */
void incr_scope() { /* go to next scope */
	cur_scope++;
}

/* print to stdout by default */ 
void symtab_dump(FILE * of) {
  int i;
  fprintf(of,"------------ ------ ------ ------------\n");
  fprintf(of,"Name         Type   Scope   Line Numbers\n");
  fprintf(of,"------------ ------ ------ -------------\n");
  for (i = 0; i < SIZE; ++i) {
	if (hash_table[i] != NULL) {
		list_t *l = hash_table[i];
		while (l != NULL) {
			reflist *t = l->lines;
			fprintf(of,"%-12s ",l->st_name);

			if (l->st_type == INT_TYPE) fprintf(of,"%-7s","int");
			else if (l->st_type == REAL_TYPE) fprintf(of,"%-7s","real");
			else if (l->st_type == STR_TYPE) fprintf(of,"%-7s","string");

			else if (l->st_type == ARRAY_TYPE){
				fprintf(of,"array of ");
				if (l->inf_type == INT_TYPE) 		   fprintf(of,"%-7s","int");
				else if (l->inf_type  == REAL_TYPE)    fprintf(of,"%-7s","real");
				else if (l->inf_type  == STR_TYPE) 	   fprintf(of,"%-7s","string");
				else fprintf(of,"%-7s","undef");
			}

			else if (l->st_type == FUNCTION_TYPE){
				fprintf(of,"%-7s %s","function returns ");
				if (l->inf_type == INT_TYPE) 		   fprintf(of,"%-7s","int");
				else if (l->inf_type  == REAL_TYPE)    fprintf(of,"%-7s","real");
				else if (l->inf_type  == STR_TYPE) 	   fprintf(of,"%-7s","string");
				else fprintf(of,"%-7s","undef");
			}

			else fprintf(of,"%-7s","undef"); // if UNDEF or 0
											 //
			fprintf(of,"  %d  ",l->scope);
			while (t != NULL) {
				fprintf(of,"%4d ",t->lineno);
				t = t->next;
			}

			fprintf(of,"\n");
			l = l->next;
		}
    }
  }
}
