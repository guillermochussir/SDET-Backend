package helpers;
import java.util.*;
import net.minidev.json.JSONArray;
import com.fasterxml.jackson.databind.*;

public class CountPhotosByCamera {
    
    public static Map<String,String> main(JSONArray arrayCamerasNames) {
		String testCaseResult = "passed";

    	List<String> listCamerasNames = new ArrayList<String>();

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			listCamerasNames = objectMapper.readValue(arrayCamerasNames.toJSONString(), List.class);
		} catch(Exception e) {
			e.printStackTrace();
		}

		Map<String, Integer> frequencyMap = new HashMap<>();
		for (String s: listCamerasNames) {
			Integer count = frequencyMap.get(s);
			if (count == null)
				count = 0;

			frequencyMap.put(s, count + 1);
            System.out.println(s);
		}

		for (Map.Entry<String, Integer> entry : frequencyMap.entrySet()) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}

		StringBuilder errorsFound = new StringBuilder();
		for (Map.Entry<String, Integer> i : frequencyMap.entrySet()) {
			System.out.println("Comparing camera:");
			System.out.println(i.getKey() + ": " + i.getValue());

			for (Map.Entry<String, Integer> j : frequencyMap.entrySet()) {
				if (i.getKey().equals(j.getKey())) continue;

				System.out.println("to camera:");
				System.out.println(j.getKey() + ": " + j.getValue());
				if (i.getValue() / j.getValue() > 10) {
					System.out.println(i.getKey() + " Camera Count is 10 times greater than " + j.getKey());
					errorsFound.append(i.getKey()).append(" Camera Count is 10 times greater than ").append(j.getKey()).append(". ");
					testCaseResult = "failed";
					}
				}
			}

		System.out.println(errorsFound);

		Map<String,String> result = new HashMap<String,String>();
		result.put("TestCaseResult",testCaseResult);
		result.put("ErrorsFound",errorsFound.toString());
		return result;
	}

}