#define LIBDPKG_VOLATILE_API 1
#define _GNU_SOURCE
#include <dpkg/dpkg.h>
#include <dpkg/version.h>
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
    struct dpkg_version a, b;
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
        if(parseversion(&a, ver1, NULL)) {
            fprintf(stderr, "cannot parse version1 %s\n", ver1);
            exit(EXIT_FAILURE);
        }
        ver2 = strsep(&token, "\n");
        if (ver2 == NULL) {
            fprintf(stderr, "cannot read token2");
            exit(EXIT_FAILURE);
        }
        if(parseversion(&b, ver2, NULL)) {
            fprintf(stderr, "cannot parse version2 %s\n", ver2);
            exit(EXIT_FAILURE);
        }
        ret = dpkg_version_compare(&a, &b);
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
