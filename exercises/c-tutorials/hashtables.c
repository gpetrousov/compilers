/* Essential hashtable
 * Code (mostly) copied from https://www.youtube.com/watch?v=2Ti5yvumFTU
 * to understand how hashtables work in C.
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_NAME 256
#define TABLE_SIZE 10
#define DELETED_NODE (Person*)(0xFFFFFFFFFFFFFFFFUL)

typedef struct {
	char name[MAX_NAME];
	int age;
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
		} else if (hash_table[i] == DELETED_NODE) {
			printf("\t%i\t--<deleted>\n", i);
		}
		else {
			printf("\t%i\t%s\n", i, hash_table[i]->name);
		}
	}
	printf("End\n");
}

bool insert_hash_table(Person *p) {
	if (p == NULL) return false;
	int hash_index = hash(p->name);
	for (int i=0; i < TABLE_SIZE; i++) {
		int try = (i + hash_index) % TABLE_SIZE;
		if (hash_table[try] == NULL || hash_table[try] == DELETED_NODE) {
			hash_table[try] = p;
			return true;
		}
	}
	return true;
}

Person *lookup_hash_table(char *name) {
	printf("Look up %s\n", name);
	int hash_index = hash(name);
	for (int i=0; i < TABLE_SIZE; i++) {
		int try = (i + hash_index) % TABLE_SIZE;
		if (hash_table[try] == NULL) {
			return false; // not here
		}
		if (hash_table[try] == DELETED_NODE) continue;
		if (strcmp(hash_table[try]->name, name)==0) {
			return hash_table[try];
		}
	}
	return NULL;
}

Person *delete_hash_table(char *name) {
	int hash_index = hash(name);
	for (int i=0; i < TABLE_SIZE; i++) {
		int try = (i + hash_index) % TABLE_SIZE;
		if (hash_table[try] == NULL) return NULL;
		if (hash_table[try] == DELETED_NODE) continue;
		if (strcmp(hash_table[try]->name, name)==0) {
			Person *tmp = hash_table[try];
			hash_table[try] = DELETED_NODE;
			printf("Deleted %s\n", tmp->name);
			return tmp;
		}
	}
	return NULL;
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
