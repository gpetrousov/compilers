/* Hashtables with chaining to avoid collisions.
 * Code (mostly) copied from https://www.youtube.com/watch?v=2Ti5yvumFTU
 * to understand how hashtables work in C.
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_NAME 256
#define TABLE_SIZE 10

typedef struct Person {
	char name[MAX_NAME];
	int age;
	struct Person *next;
} Person;

Person *hash_table[TABLE_SIZE];

unsigned int hash(char *name) {
	int length = strlen(name);
	unsigned int hash_value;
	for (int i=0; i < length; i++) {
		hash_value += name[i];
		hash_value = hash_value * name[i] %TABLE_SIZE;
	}
	return hash_value;
}

bool init_hash_table() {
	for (int i=0; i<TABLE_SIZE; i++) {
		hash_table[i] = NULL;
	}
}

void print_hash_table() {
	printf("\nStart\n");
	for (int i=0; i<TABLE_SIZE; i++) {
		if (hash_table[i] == NULL) {
			printf("\t%i\t--\n", i);
		} else {
			Person *tmp = hash_table[i];
			while (tmp != NULL) {
				printf("%s - ", tmp->name);
				tmp = tmp->next;
			}
			printf("\n");
		}
	}
	printf("End\n");
}

bool insert_hash_table(Person *p) {
	if (p == NULL) return false;
	printf("Insert %s\n", p->name);
	int hash_index = hash(p->name);
	p->next = hash_table[hash_index];
	hash_table[hash_index] = p;
	return true;
}

Person *lookup_hash_table(char *name) {
	printf("Look up %s\n", name);
	int hash_index = hash(name);
	Person *tmp = hash_table[hash_index];
	while (tmp != NULL && strcmp(tmp->name, name) !=0 ) {
		tmp = tmp->next;
	}
	return tmp;
}

Person *delete_hash_table(char *name) {
	int hash_index = hash(name);
	Person *tmp = hash_table[hash_index];
	Person *prev = NULL;
	while (tmp != NULL && strcmp(tmp->name, name) !=0 ) {
		prev = tmp;
		tmp = tmp->next;
	}
	if (tmp == NULL) return NULL; // Does not exist
	if (prev == NULL) {
		hash_table[hash_index] = tmp->next;
	} else {
		prev->next = tmp->next; // Actual deletion is a shift in the chain
	}
	return tmp;
}


int main() {
	init_hash_table();
	print_hash_table();

	Person jacob = {.name="Jacob", .age=23};
	Person steven = {.name="Steven", .age=34};
	Person anna = {.name="Anna", .age=12};
	Person kygo = {.name="Kygo", .age=27};
	Person eliza = {.name="Eliza", .age=43};
	Person jane = {.name="Jane", .age=33};
	Person robert = {.name="Robert", .age=78};
	Person maren = {.name="Maren", .age=41};
	Person bill = {.name="Bill", .age=14};

	insert_hash_table(&jacob);
	insert_hash_table(&steven);
	insert_hash_table(&anna);
	insert_hash_table(&kygo);
	insert_hash_table(&eliza);
	insert_hash_table(&jane);
	insert_hash_table(&robert);
	insert_hash_table(&maren);
	insert_hash_table(&bill);

	print_hash_table();

	Person *tmp = lookup_hash_table("Anna");
	if (tmp == NULL) {
		printf("Not found!\n");
	} else {
		printf("Found: %s\n", tmp->name);
	}

	tmp = lookup_hash_table(("Kygo"));
	if (tmp == NULL) {
		printf("Not found!\n");
	} else {
		printf("Found: %s\n", tmp->name);
	}

	delete_hash_table("Anna");
	tmp = lookup_hash_table("Anna");
	if (tmp == NULL) {
		printf("Not found!\n");
	} else {
		printf("Found: %s\n", tmp->name);
	}

	print_hash_table();


	//printf("Jacob ==> %u\n", hash("Jacob"));
	//printf("Natalie ==> %u\n", hash("Natalie"));
	//printf("Sara ==> %u\n", hash("Sara"));
	//printf("Ron ==> %u\n", hash("Sara"));
	//printf("Maren ==> %u\n", hash("Sara"));
	//printf("Josh ==> %u\n", hash("Sara"));
	//printf("Alita ==> %u\n", hash("Sara"));
	//printf("Tebogo ==> %u\n", hash("Sara"));
	//printf("Bill ==> %u\n", hash("Sara"));
	//printf("Gill ==> %u\n", hash("Sara"));

	return 0;
}
