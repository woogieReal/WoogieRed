package java_api_class;


import java.time.LocalDateTime;


public class G_LocalDateTime {

	public static void main(String[] args) {

		LocalDateTime present = LocalDateTime.now();
		System.out.println(present);
		
		LocalDateTime yesterday = present.minusDays(1);
		LocalDateTime twoDaysAgo = present.minusDays(2);
		LocalDateTime threeHoursAgo = present.minusHours(3);
		LocalDateTime fourMinutesAgo = present.minusMinutes(4);
		
		System.out.println(yesterday);
		System.out.println(twoDaysAgo);
		System.out.println(threeHoursAgo);
		System.out.println(fourMinutesAgo);
		
		LocalDateTime sixDaysAndSevenHoursAgo = present.minusDays(6).minusHours(7);
		System.out.println(sixDaysAndSevenHoursAgo);
	}

}
