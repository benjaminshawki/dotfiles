package nl.hsleiden.inf.iad1;

public class LZW {
	private static int counter = 256;
	public static void main(String[] args) {
		encode("BLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLA");
	}

	public static void encode(String text) {
		String[] dic = createDictionary();
		String p = "";
		String c = "";

		try {
			Thread.sleep(10000000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		for (int i = 0; i <= text.length(); i++) {
			
			if(i != text.length()) {
				c = text.substring(i, i + 1);
			}
			int index = getIndex(p + c, dic);
			if (index != -1) {
				p = p + c;
			} else {
				System.out.println(getIndex(p, dic) + " - '" + p + "'");
				dic[counter] = p + c;
				counter++;
				p = c;
			}
		}

	}

	private static String[] createDictionary() {
		String[] dic = new String[4096];
		for (int i = 0; i <= 255; i++) {
			dic[i] = (char) i + "";
		}
		return dic;
	}

	private static int getIndex(String tokens, String[] dic) {
		for (int i = 0; i < counter-1; i++) {
			if (dic[i].equals(tokens)) {
				return i;
			}
		}
		return -1;
	}
}
