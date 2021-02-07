Feature: User is query Mars Rover Photos

    Background: Define URL
        Given url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

    @smoke
    Scenario: User is able to retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
        Given params { sol: 1000, page: 1, api_key: 'DEMO_KEY'}
        Given path 'curiosity/photos'
        When method get
        Then status 200
        And match response.photos == '#[25]'
        And match response.photos[0].rover.name == 'Curiosity'
        And match response.photos[0].sol == 1000