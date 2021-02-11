Feature: User is able query Mars Rover Photos

    Background: Define URL
    Given url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

    @smoke
    Scenario: User is able to retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    * def result = call read('classpath:helpers/getPhotosByMartianSolOnlyFirstPage.feature') {date: 1000, roverName: 'Curiosity'}
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
    * def result = call read('classpath:helpers/getPhotosByEarthDateOnlyFirstPage.feature') {date: '2015-5-30', roverName: 'Curiosity'}
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

    @sanity
    Scenario: Compare Photos
    #retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    * def result = call read('classpath:helpers/getPhotosByMartianSolOnlyFirstPage.feature') {date: 1000, roverName: 'Curiosity'}
    * def photos = result.response.photos
    * def martialSolImageUrls = []
    * def retrieveImageSource = function(i){ karate.appendTo(martialSolImageUrls, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    #retrieve the first 10 Mars photos made by "Curiosity" on Earth date 30/5/2015
    * def result = call read('classpath:helpers/getPhotosByEarthDateOnlyFirstPage.feature') {date: '2015-5-30', roverName: 'Curiosity'}
    * def photos = result.response.photos
    * def earthDateImageUrls = []
    * def retrieveImageSource = function(i){ karate.appendTo(earthDateImageUrls, photos[i].img_src) }
    * karate.repeat(10, retrieveImageSource)
    And match martialSolImageUrls == earthDateImageUrls

    @sanity
    Scenario: Amounts of pictures that each "Curiosity" camera took on 1000 Mars sol is not greater than 10 times the amount taken by other cameras
        # threshold = test case fails if amount of pictures is more than X times greater
        * def threshold = 10
        * def result = call read('classpath:helpers/getPhotosByMartianSolNoPageFilter.feature') {date: 1000, roverName: 'Curiosity'}
        * def photos = result.response.photos
        And match each photos..sol == 1000
        * def camerasNames = []
        * def getCamerasNames = function(x){ karate.appendTo(camerasNames, x.camera.name) }
        * karate.forEach(photos, getCamerasNames)
        * def CountPhotosByCamera = Java.type('helpers.CountPhotosByCamera')
        * def payload = {CamerasNames: #(camerasNames), Threshold: #(threshold) }
        * def result = CountPhotosByCamera.main(payload)
        * print result.ErrorsFound
        * assert result.StepResult == "passed"