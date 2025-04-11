package org.benchmarkplayground.utils; 

public final class GeneralUtilities {
    public static double roundToDecimals(double value, short precision) {
        double factor = Math.pow(10, precision);
        return (double)Math.round(value * factor) / factor;
    }
}
