#include <apt-pkg/debversion.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char *line = NULL;
    char *token;
    char *orig1;
    char *orig2;
    char *ver1;
    char *ver2;
    size_t len = 0;
    size_t read;
    int ret;
    while ((read = getline(&line, &len, stdin)) != -1) {
        //fprintf(stderr, "%s", line);
        orig1 = strdup(line);
        orig2 = strdup(line);
        token = orig1;
        ver1 = strsep(&token, "\t");
        if (ver1 == NULL) {
            fprintf(stderr, "cannot read token1");
            exit(EXIT_FAILURE);
        }
        ver2 = strsep(&token, "\n");
        if (ver2 == NULL) {
            fprintf(stderr, "cannot read token2");
            exit(EXIT_FAILURE);
        }
        ret = debVS.CmpVersion(ver1, ver2);
        if (ret == 0) {
            fputc('=', stdout);
        } else if (ret > 0) {
            fputc('>', stdout);
        } else {
            fputc('<', stdout);
        }
        //fputs(orig2, stdout);
        free(orig1);
        free(orig2);
    }
    exit(EXIT_SUCCESS);
}
