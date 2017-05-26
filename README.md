# README

It's tiny RESTful API to index a page's content. I.e. to store the content that is found inside the tags h1, h2 and h3 and the links.

## How to setup

* check if you have needed ruby version installed

* `bundle install`

* `bin/setup`

## Ready to start

* `bundle exec rails s`

## Workflow

![Imgur](http://i.imgur.com/mlI1wJJ.png)

## API endpoints

* Notice: URL should include http(s)://

1 **GET /api/v1/parsings?page=...&per_page=... - index**
###  Examples:
  * request: GET /api/v1/parsings

    response:

    ```
    {
      "current_page": 1, "total_pages": 1, "total_count": 11, "per_page_count": 11,
      "parsings": [
        {
          "parsing": {
            "id": 12,
            "created_at": "2017-05-25T12:52:27.935Z",
            "status": "completed",
            "url": "http://example.com",
            "links": [
              {
                "content": "http://www.iana.org/domains/example"
              }
            ],
            "h1": [
              {
                "content": "Example Domain"
              }
            ],
            "h2": [],
            "h3": []
          }
        },
        ...
        {
          "parsing": {...}
        },
      ]
    }
    ```

  * request: GET /api/v1/parsings?page=2&per_page=5

    response:

    ```
    {
      "current_page": 2, "total_pages": 3, "total_count": 11, "per_page_count": 5,
      "parsings": [
        {
          "parsing": {
            "id": 12,
            "created_at": "2017-05-25T12:52:27.935Z",
            "status": "completed",
            "url": "http://example.com",
            "links": [
              {
                "content": "http://www.iana.org/domains/example"
              }
            ],
            "h1": [
              {
                "content": "Example Domain"
              }
            ],
            "h2": [],
            "h3": []
          }
        },
        ...
        {
          "parsing": {...}
        },
      ]
    }
    ```

2 **GET /api/v1/parsings/:id - show**

### Examples:
  * request: GET /api/v1/parsings/12

    response:

    ```
    {
      "parsing": {
        "id": 12,
        "created_at": "2017-05-25T12:52:27.935Z",
        "status": "completed",
        "url": "http://example.com",
        "links": [
          {
            "content": "http://www.iana.org/domains/example"
          }
        ],
        "h1": [
          {
            "content": "Example Domain"
          }
        ],
        "h2": [],
        "h3": []
      }
    }
    ```


3 **POST /api/v1/parsings - create**
  
  parameters:
    * url - page to index

    * success_callback_url - url to receive indexed page if successfull

    * failure_callback_url - url to receive fail message if failed

  ```
  {
    "parsing": {
      "url": "http://example.com",
      "success_callback_url": "http://example.com/success",
      "failure_callback_url": "http://example.com/failure"
    }
  }
  ```

###  Examples:
  * request: POST /api/v1/parsings

    parameters: 
    ```
    {
      "parsing": {
        "url": "http://example.com",
        "success_callback_url": "http://example.com/success",
        "failure_callback_url": "http://example.com/failure"
      }
    }
    ```

    response: 
    ```
    {
      "parsing": {
        "id": 11,
        "created_at": "2017-05-25T12:23:30.154Z",
        "status": "pending",
        "url": "http://example.com",
        "links": [],
        "h1": [],
        "h2": [],
        "h3": []
      }
    }
    ```

## Tests

* `rspec spec`
