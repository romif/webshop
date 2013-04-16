package util;

import java.security.MessageDigest;

import servlet.RequestDecoder;

public class MD5 {
	private static MD5 instance=null;
	
	public static MD5 getInstance(){
		if (instance==null) instance=new MD5();
		return instance;
	}
	
    public String getMD5(String source) {
        String res = "";
        try {
            MessageDigest md = MessageDigest.getInstance("md5");
            md.update(source.getBytes());
            String md5 = convertToHex(md.digest());
            res = md5;
        } catch (Exception e) {
        }

        return res;
    }

    private static String convertToHex(byte[] srcData) {
        StringBuilder sbuffer = new StringBuilder();
        for (int i = 0; i < srcData.length; i++) {
            int flag = (srcData[i] >>> 4) & 0x0F;
            int twoHalf = 0;
            do {
                if ((0 <= flag) && (flag <= 9)) {
                    sbuffer.append((char) ('0' + flag));
                } else {
                    sbuffer.append((char) ('a' + (flag - 10)));
                }
                flag = srcData[i] & 0x0F;
            } while (twoHalf++ < 1);
        }
        return sbuffer.toString();
    }
    
    public static void main(String[] args){
    	System.out.println(MD5.getInstance().getMD5("loveyou"));
    	System.out.println(MD5.getInstance().getMD5("password"));
    }
}
