package io.renren.utils;

import org.apache.commons.lang.StringUtils;

public class Tools {
    
    private Tools() {
        
    }
    
    public static String delNull(String src) {
        if(StringUtils.isBlank(src)) {
            return "";
        }
        return src.trim();
    }
    
    public static String getTimeStamp() {
        return String.valueOf(System.currentTimeMillis());
    }
    
}
