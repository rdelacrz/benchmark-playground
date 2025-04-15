/**
 * Rounds value based on the given precision.
 * @param value Value being rounded.
 * @param precision The number of decimals to round value to.
 * @returns Rounded value.
 */
export function roundToDecimals(value: number, precision: number) {
    const factor = Math.pow(10, precision);
    return Math.round(value * factor) / factor;
}