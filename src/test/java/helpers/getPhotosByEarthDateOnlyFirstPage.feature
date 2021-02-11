Feature: Helper for Get Method

    Background: Define URL
        Given url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

    Scenario: Get Photos by Earth Date
        Given params {earth_date: #(date), page: 1, api_key: 'Ko3x5ubu3ZkB7T1PFezoQ9E39GkAovTutyr4PJSb'}
        Given path roverName
        Given path 'photos'
        When method get
        Then status 200