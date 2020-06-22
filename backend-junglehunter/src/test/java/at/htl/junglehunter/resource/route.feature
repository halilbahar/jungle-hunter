Feature: Test the route endpoint

  Background:
    * url 'http://localhost:8081'
    * def getLastUrlPart =
    """
    function(url) {
      var split = url.split('/');
      return split[split.length - 1];
    }
    """

  Scenario: Create, get by id and delete route
    Given path 'route'
    And def body =
    """
    {
      "name": "Route starting in Linz",
      "start": "Linz",
      "url": "https://www.linz.at",
      "description": "This is a route starting in Linz"
    }
    """
    And request body
    When method post
    Then status 201
    And def id = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'route', id
    And set body.id = '#number'
    And set body.trails = []
    When method get
    Then status 200
    Then match response == body
    And def routeGetResponse = response

    Given path 'route', id
    When method delete
    Then status 200
    Then match response == routeGetResponse


  Scenario: Get all routes
    Given path 'route'
    When method get
    Then status 200
    Then match response == '#array'


  Scenario: Get a route that doesn't exist
    Given path 'route', 666
    When method get
    Then status 404


  Scenario: Create a route with empty body
    Given path 'route'
    And request { }
    When method post
    Then status 422
    Then response.length == 4

  Scenario: Create a route with too long values
    Given path 'route'
    And def body =
      """
      ({ name: nString(101), start: nString(101), url: nString(256), description: nString(256) })
      """
    And request body
    When method post
    Then status 422
    Then match response == '#[4]'


  Scenario: Try to create a route with a existing name
    Given path 'route'
    And request { name: 'Route starting in Salzburg', start: 'Salzburg', url: 'https://www.salzburg.info/de', description: 'This is a route starting in Salzburg' }
    When method post
    Then status 201
    And def id = getLastUrlPart( responseHeaders['Location'][0] )

    Given path 'route'
    And request { name: 'Route starting in Salzburg', start: 'Salzburg', url: 'https://www.salzburg.info/de', description: 'This is a route starting in Salzburg' }
    When method post
    Then status 422
    Then match response == '#[1]'

    Given path 'route', id
    When method delete
    Then status 200

