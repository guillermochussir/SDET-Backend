Feature: Helper for Get Method

    Background: Define URL
        Given url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

    Scenario: Get Photos by Martian Sol
        Given params {sol: #(date), api_key: 'Ko3x5ubu3ZkB7T1PFezoQ9E39GkAovTutyr4PJSb'}
        Given path roverName
        Given path 'photos'
        When method get
        Then status 200