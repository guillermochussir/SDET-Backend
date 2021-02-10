package helpers;
import java.util.*;

import com.sun.org.apache.bcel.internal.generic.RETURN;
import net.minidev.json.JSONArray;
import com.fasterxml.jackson.databind.*;

public class CountPhotosByCamera {
    
    public static void main(JSONArray arr) {

		List<String> list = new ArrayList<String>();

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			list = objectMapper.readValue(arr.toJSONString(), List.class);
		} catch(Exception e) {
			e.printStackTrace();
		}

		Map<String, Integer> frequencyMap = new HashMap<>();
		System.out.println("Calculating frequencies...");
		for (String s: list) {
			Integer count = frequencyMap.get(s);
			if (count == null)
				count = 0;

			frequencyMap.put(s, count + 1);
            System.out.println(s);
		}

		for (Map.Entry<String, Integer> entry : frequencyMap.entrySet()) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}

		String currentCameraName = "";
		int currentCameraCount = 0;
		StringBuilder ErrorsFound = new StringBuilder();
		for (Map.Entry<String, Integer> i : frequencyMap.entrySet()) {
			System.out.println("Comparing camera:");
			System.out.println(i.getKey() + ": " + i.getValue());

			currentCameraName = i.getKey();
			currentCameraCount = i.getValue();

			for (Map.Entry<String, Integer> j : frequencyMap.entrySet()) {
				System.out.println("to camera:");
				System.out.println(j.getKey() + ": " + j.getValue());
				if (currentCameraCount / j.getValue() > 10) {
					System.out.println(currentCameraName + " Camera Count is 10 times greater than " + j.getKey());
					ErrorsFound.append(currentCameraName).append(" Camera Count is 10 times greater than ").append(j.getKey()).append(". ");
					}
				}
			}

		System.out.println(ErrorsFound);

		}

}