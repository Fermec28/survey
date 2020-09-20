# Surveys

## Description

This project is an API to create and fill surveys

Requiriments:

- Users must be able to create an account and log in.
- When logged in, the project allows users to create and share surveys. 
- Each survey has many questions. 
- Each question has many options. For now we are going to support only single choice questions, but in the future we might support other type of questions.
- Anyone can fill a survey, they are going to be public.
- The owner of the survey can see the responses and a summary of the questions in a pie chart.
- All actions need to be done client side using AJAX. The page shouldn't reload.
- Minimal UX/UI . You will not be tested on this but try to keep it as tidy as possible.
- Use a REST API. It should be possible to perform all actions via the API.
- Only tests for the REST layer are required.

## How to used the API📦

### Login User

#### create an User
```bash
curl -X POST -H "Content-Type: application/json" -d'{"user": {"email": "b@a.com", "password": "test", "password_confirmation": "test"}}' http://localhost:3000/api/v1/users
```
Response: 
```bash
{"Authorization":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4wBWO1V8e-2SpT_TqvZLsnAp6-SLTgbQZjyaMQpEqpY","id":2,"email":"b@a.com"}
```

You will use this Authorization as  header to make all the request.

### login as user

```bash
curl -X POST -H "Content-Type: application/json" -d'{"email": "b@a.com", "password": "test"}' http://localhost:3000/api/v1/login
```

```
{"Authorization":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg","id":1,"email":"a@a.com"}

```

### list surveys
```bash
curl -X GET  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg" -H "Content-Type: application/json" http://localhost:3000/api/v1/surveys
```

```json
[
   {
      "id":1,
      "description":"new survey",
      "questions":[
         {
            "id":1,
            "description":"question",
            "options":[
               {
                  "id":1,
                  "description":"option"
               }
            ]
         },
         {
            "id":2,
            "description":"question2",
            "options":[
               
            ]
         },
         {
            "id":3,
            "description":"question3",
            "options":[
               
            ]
         },
         {
            "id":4,
            "description":"question",
            "options":[
               
            ]
         }
      ]
   }
]
```

You can use your token to retrieve all the data required

## How to used the Project locally 🔧

1. Clone the reposiroty:

   `git clone https://github.com/Fermec28/survey.git`

2. Go to project folder:

   `cd survey`

3. Install dependencies:

   `bundle install`

4. Create Data Base:

   `rails db:create`

5. Run Migrations:

   Execute:
   `rails db:migrate`

6. Run Tests:

   Execute:
   `bundle exec rspec`

7. Run server:

   Execute:
   `rails s`

# Dependencies
- ruby 2.7.0p0
- Rails 6.0.3.3

## Author ✒️

- [Ferney Medina](https://github.com/Fermec28)


You can report any issue [here](https://github.com/Fermec28/survey/projects/1)
