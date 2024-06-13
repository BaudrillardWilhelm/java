package com.qdu.util;

import java.util.Calendar;
import java.util.Date;

public class DateUtil {
    public static Date getStartDate(int days) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, days);
        return cal.getTime();
    }
}
