Feature: Test the trail endpoint

  Background:
    * url 'http://localhost:8081'
    * def getLastUrlPart =
    """
    function(url) {
      var split = url.split('/');
      return split[split.length - 1];
    }
    """

  Scenario: Create, get by route id and delete trail
    Given path 'route'
    And def body =
    """
    {
      "name": "Laaammoollllaaa",
      "start": "leonding",
      "url": "http://localhost",
      "description": "My description"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Vienna', length: 123.69 }
    And request body
    When method post
    Then status 204

    Given path 'trail','route', routeId
    When method get
    Then status 200
    Then match response == '#array'
    And def trailGetResponse = response[0]
    And def trailId = trailGetResponse.id

    Given path 'trail', trailId
    When method delete
    Then status 200
    Then match response == trailGetResponse

    Given path 'route', routeId
    When method delete
    Then status 200

  Scenario: Get trails from route that doesn't exist
    Given path 'trail', 'route', 666
    When method get
    Then status 404

  Scenario: Create a trail with too long name
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Vienna",
      "start": "Vienna",
      "url": "https://www.wien.gv.at",
      "description": "This is a route starting in Vienna"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail', 'route', routeId
    And def body =
    """
      ({ name: nString(101), length: 123.69 })
    """
    And request body
    When method post
    Then status 422

    Given path 'route', routeId
    When method delete
    Then status 200

  Scenario: Create a trail with empty length
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Vienna",
      "start": "Vienna",
      "url": "https://www.wien.gv.at",
      "description": "This is a route starting in Vienna"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail', 'route', routeId
    And def body = { name: 'Trail Vienna' }
    And request body
    When method post
    Then status 422

    Given path 'route', routeId
    When method delete
    Then status 200

  Scenario: Try to create a trail with an existing name
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Vienna",
      "start": "Vienna",
      "url": "https://www.wien.gv.at",
      "description": "This is a route starting in Vienna"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Vienna', length: 123.69 }
    And request body
    When method post
    Then status 204

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Vienna', length: 123.69 }
    And request body
    When method post
    Then status 422

    Given path 'trail','route', routeId
    When method get
    Then status 200
    Then match response == '#array'
    And def trailGetResponse = response[0]
    And def trailId = trailGetResponse.id

    Given path 'trail', trailId
    When method delete
    Then status 200
    Then match response == trailGetResponse

    Given path 'route', routeId
    When method delete
    Then status 200
