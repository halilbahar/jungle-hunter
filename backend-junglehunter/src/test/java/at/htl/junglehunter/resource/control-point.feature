Feature: Test the control point endpoint

  Background:
    * url 'http://localhost:8080'
    * def getLastUrlPart =
    """
    function(url) {
      var split = url.split('/');
      return split[split.length - 1];
    }
    """

  Scenario: Create, get by trail id and delete a control point
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Leonding",
      "start": "Leonding",
      "url": "https://www.leonding.at/startseite/",
      "description": "This is a route starting in Leonding"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Upper Austria', length: 123.69 }
    And request body
    When method post
    Then status 204

    Given path 'trail','route', routeId
    When method get
    Then status 200
    Then match response == '#array'
    And def trailId = response[0].id

    Given path 'control-point', 'trail', trailId
    And def body = { name: 'Leonding Control Point', comment: 'This is a control point in Leonding', note: 'It is in Upper Austria', latitude: 48.27965, longitude: 14.2533 }
    And request body
    When method post
    Then status 204

    Given path 'control-point','trail', trailId
    When method get
    Then status 200
    Then match response == '#array'
    And def controlPointGetResponse = response[0]
    And def controlPointId = controlPointGetResponse.id

    # Given path 'control-point', controlPointId
    # When method delete
    # Then status 200
    # Then match response == controlPointGetResponse

    Given path 'trail', trailId
    When method delete
    Then status 200

    Given path 'route', routeId
    When method delete
    Then status 200

  Scenario: Get all control points from trail that doesn't exist
    Given path 'control-point', 'trail', 666
    When method get
    Then status 404

  Scenario: Create control points with too long values
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Leonding",
      "start": "Leonding",
      "url": "https://www.leonding.at/startseite/",
      "description": "This is a route starting in Leonding"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Upper Austria', length: 123.69 }
    And request body
    When method post
    Then status 204

    Given path 'trail','route', routeId
    When method get
    Then status 200
    Then match response == '#array'
    And def trailId = response[0].id

    Given path 'control-point', 'trail', trailId
    And def body =
    """
      ({ name: nString(51), comment: nString(256), note: nString(256), latitude: 181, longitude: -181 })
    """
    And request body
    When method post
    Then status 422

    Given path 'trail', trailId
    When method delete
    Then status 200

    Given path 'route', routeId
    When method delete
    Then status 200

  Scenario: Create empty control
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Leonding",
      "start": "Leonding",
      "url": "https://www.leonding.at/startseite/",
      "description": "This is a route starting in Leonding"
    }
    """
    And request body
    When method post
    Then status 201
    And def routeId = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'trail','route', routeId
    And def body = { name: 'Trail Upper Austria', length: 123.69 }
    And request body
    When method post
    Then status 204

    Given path 'trail','route', routeId
    When method get
    Then status 200
    Then match response == '#array'
    And def trailId = response[0].id

    Given path 'control-point', 'trail', trailId
    And def body = { }
    And request body
    When method post
    Then status 422

    Given path 'trail', trailId
    When method delete
    Then status 200

    Given path 'route', routeId
    When method delete
    Then status 200
