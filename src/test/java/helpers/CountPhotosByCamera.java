package helpers;
import java.util.*;
import java.util.LinkedHashMap;
import com.fasterxml.jackson.databind.*;

public class CountPhotosByCamera {

	public static Map<String,String> main(LinkedHashMap arg) {
		List<String> listCamerasNames = new ArrayList<String>();
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			listCamerasNames = objectMapper.readValue(arg.get("CamerasNames").toString(), List.class);
		} catch(Exception e) {
			e.printStackTrace();
		}

		Map<String, Double> frequencyMap = new HashMap<>();
		for (String s: listCamerasNames) {
			Double count = frequencyMap.get(s);
			if (count == null)
				count = 0.0;
			frequencyMap.put(s, count + 1);
		}

		StringBuilder errorsFound = new StringBuilder();
		String stepResult = "passed";
		errorsFound.append("Errors Found:");
		for (Map.Entry<String, Double> i : frequencyMap.entrySet()) {
			for (Map.Entry<String, Double> j : frequencyMap.entrySet()) {
				if (i.getKey().equals(j.getKey())) continue;
				if (( i.getValue() / j.getValue() > (int) arg.get("Threshold"))) {
					errorsFound.
							append(System.lineSeparator()).
							append("Amount of pictures taken by ").
							append(i.getKey()).
							append(" is more than ").
							append(arg.get("Threshold")).
							append(" times greater than ").
							append(j.getKey()).
							append(". ").
							append((int) Math.round(i.getValue())).
							append(" vs ").
							append((int) Math.round(j.getValue()));
					stepResult = "failed";
				}
			}
		}

		if (stepResult.equals("passed")) { errorsFound.append(System.lineSeparator()).append("None"); }
		Map<String,String> result = new HashMap<String,String>();
		result.put("StepResult",stepResult);
		result.put("ErrorsFound",errorsFound.toString());
		return result;
	}

}