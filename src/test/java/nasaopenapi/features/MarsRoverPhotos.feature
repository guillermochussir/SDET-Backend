Feature: User is query Mars Rover Photos

    Background: Define URL
    Given url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

    @smoke
    Scenario: User is able to retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    * def result = call read('classpath:helpers/getPhotosByMartianSol.feature') {date: 1000}
    * def photos = result.response.photos
    And match photos == "#array"
    And match photos == '#[25]'
    And match each photos == {"id":"#number","sol":"#number","camera":"#object","img_src":"#string","earth_date":"#string","rover":"#object"}
    And match each photos..rover.name == 'Curiosity'
    And match each photos..sol == 1000
    And match each photos..earth_date == '2015-05-30'
    * def imageURLs = []
    * def retrieveImageSource = function(i){ karate.appendTo(imageURLs, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    * def imageURLs = karate.lowerCase(imageURLs)
    And match each imageURLs contains '.jpg'

    @smoke
    Scenario: User is able to retrieve the first 10 Mars photos made by "Curiosity" on Earth date 30/5/2015
    * def result = call read('classpath:helpers/getPhotosByEarthDate.feature') {date: '2015-5-30'}
    * def photos = result.response.photos
    And match photos == "#array"
    And match photos == '#[25]'
    And match each photos == {"id":"#number","sol":"#number","camera":"#object","img_src":"#string","earth_date":"#string","rover":"#object"}
    And match each photos..rover.name == 'Curiosity'
    And match each photos..sol == 1000
    And match each photos..earth_date == '2015-05-30'
    * def imageURLs = []
    * def retrieveImageSource = function(i){ karate.appendTo(imageURLs, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    * def imageURLs = karate.lowerCase(imageURLs)
    And match each imageURLs contains '.jpg'

    @smoke
    Scenario: Compare Photos
    #retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    * def result = call read('classpath:helpers/getPhotosByMartianSol.feature') {date: 1000}
    * def photos = result.response.photos
    And match photos == "#array"
    And match photos == '#[25]'
    And match each photos == {"id":"#number","sol":"#number","camera":"#object","img_src":"#string","earth_date":"#string","rover":"#object"}
    And match each photos..rover.name == 'Curiosity'
    And match each photos..sol == 1000
    And match each photos..earth_date == '2015-05-30'
    * def martialSolImageUrls = []
    * def retrieveImageSource = function(i){ karate.appendTo(martialSolImageUrls, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    * def martialSolImageUrls = karate.lowerCase(martialSolImageUrls)
    And match each martialSolImageUrls contains '.jpg'
    #retrieve the first 10 Mars photos made by "Curiosity" on Earth date 30/5/2015
    * def result = call read('classpath:helpers/getPhotosByEarthDate.feature') {date: '2015-5-30'}
    * def photos = result.response.photos
    And match photos == "#array"
    And match photos == '#[25]'
    And match each photos == {"id":"#number","sol":"#number","camera":"#object","img_src":"#string","earth_date":"#string","rover":"#object"}
    And match each photos..rover.name == 'Curiosity'
    And match each photos..sol == 1000
    And match each photos..earth_date == '2015-05-30'
    * def earthDateImageUrls = []
    * def retrieveImageSource = function(i){ karate.appendTo(earthDateImageUrls, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    * def earthDateImageUrls = karate.lowerCase(earthDateImageUrls)
    And match each earthDateImageUrls contains '.jpg'
    And match martialSolImageUrls == earthDateImageUrls

    
    
    @smoke @flaky
    Scenario: Example FlakyTest
        Given params { sol: 999, page: 1, api_key: 'DEMO_KEY'}
        Given path 'curiosity/photo'
        When method get
        Then status 200
        And match response.photos == '#[25]'
        And match response.photos[0].rover.name == 'Curiosity'
        And match response.photos[0].sol == 1000