#include "converter.h"

#include <limits.h>
#include <stddef.h>

static int char_to_value(char c) {
    if (c >= '0' && c <= '9')
        return c - '0';

    if (c >= 'A' && c <= 'F')
        return c - 'A' + 10;

    if (c >= 'a' && c <= 'f')
        return c - 'a' + 10;

    return -1;
}

static char value_to_char(int value) {
    if (value < 10)
        return '0' + value;

    return 'A' + (value - 10);
}

static int to_decimal(
    const char *number,
    int base,
    unsigned long long *result
) {
    *result = 0;

    if (number == NULL || number[0] == '\0')
        return CONVERT_INVALID_INPUT;

    for (int i = 0; number[i] != '\0'; i++) {
        int digit = char_to_value(number[i]);

        if (digit < 0)
            return CONVERT_INVALID_INPUT;

        if (digit >= base)
            return CONVERT_INVALID_INPUT;

        /*
         * Check for overflow BEFORE:
         *
         * result = result * base + digit;
         *
         * This prevents unsigned integer wraparound.
         */
        if (*result > (ULLONG_MAX - digit) / base)
            return CONVERT_OVERFLOW;

        *result = *result * base + digit;
    }

    return CONVERT_SUCCESS;
}

static void from_decimal(
    unsigned long long decimal,
    int base,
    char *result
) {
    char temp[65];
    int i = 0;

    if (decimal == 0) {
        result[0] = '0';
        result[1] = '\0';
        return;
    }

    /*
     * Repeated division:
     *
     * remainder = decimal % base
     * decimal = decimal / base
     *
     * Digits are produced backwards, so we reverse them afterward.
     */
    while (decimal > 0) {
        int remainder = decimal % base;

        temp[i] = value_to_char(remainder);
        i++;

        decimal = decimal / base;
    }

    for (int j = 0; j < i; j++) {
        result[j] = temp[i - j - 1];
    }

    result[i] = '\0';
}

int convert_number(
    const char *input,
    int source_base,
    int target_base,
    char *output
) {
    unsigned long long decimal;

    if (input == NULL || output == NULL)
        return CONVERT_INVALID_INPUT;

    if (source_base < 2 || source_base > 16)
        return CONVERT_INVALID_BASE;

    if (target_base < 2 || target_base > 16)
        return CONVERT_INVALID_BASE;

    int conversion_status =
        to_decimal(
            input,
            source_base,
            &decimal
        );

    if (conversion_status != CONVERT_SUCCESS)
        return conversion_status;

    from_decimal(
        decimal,
        target_base,
        output
    );

    return CONVERT_SUCCESS;
}
