package helpers;
import java.util.*;
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
		for (String s: list) {
			Integer count = frequencyMap.get(s);
			if (count == null)
				count = 0;

			frequencyMap.put(s, count + 1);
            System.out.println(s);
		}

        System.out.println("Calculating frequencies...");

		for (Map.Entry<String, Integer> entry : frequencyMap.entrySet()) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}

		}
	}