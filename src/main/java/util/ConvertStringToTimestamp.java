package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ConvertStringToTimestamp {

	public static Timestamp convertStringToTimestamp(String dateTime, String format) {
		if (dateTime == null)
			return null;

		try {
			Date date = new SimpleDateFormat(format).parse(dateTime);
			return new Timestamp(date.getTime());
		} catch (Exception e) {
			return null;
		}

	}
}