#ifndef CONVERTER_H
#define CONVERTER_H

#define CONVERT_SUCCESS 1
#define CONVERT_INVALID_INPUT 0
#define CONVERT_INVALID_BASE -1
#define CONVERT_OVERFLOW -2

int convert_number(
    const char *input,
    int source_base,
    int target_base,
    char *output
);

#endif
