# How To Run Tests

## Run Tests from Terminal or CLI:
#### Run all tests (Excludes flaky tests by default)
```
mvn test
```

#### Run Smoke Test Suite (Excludes flaky tests)
```
mvn test "-Dkarate.options=--tags @smoke --tags ~@flaky"
```

#### Run Smoke Test Suite (Includes flaky tests)
```
mvn test "-Dkarate.options=--tags @smoke"
```

#### Run all flaky tests in Smoke Test Suite (Excludes non-flaky tests)
```
mvn test "-Dkarate.options=--tags @smoke --tags @flaky"
```

#### Run Sanity Test Suite (Excludes flaky tests)
```
mvn test "-Dkarate.options=--tags @sanity --tags ~@flaky"
```



## Run Tests from VS Code

**Requirements: Everything must be setup as described in SETUP.MD**

Open the .feature file and click on **Karate: Run** over the Feature title to execute the whole feature file.

Click on **Karate: Run** over a specific Scenario to only execute that scenario.

![VS Code Screenshot](Karate-run-on-VS-Code.jpg?raw=true "VS Code Screenshot")

## See test results

After a test is run, a file is generated on **target/surefire-reports/karate-summary.html**

![Karate Summary Report](Karate-Summary-Report.jpg?raw=true "Karate Summary Report")