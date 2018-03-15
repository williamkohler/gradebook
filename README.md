# Gradebook

Gradebook application for teachers students and administrators to manage courses.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install
```

Migrate the database:

```
$ rails db:migrate
```

Seed the database:

```
$ rails db:seed
```

Run the test suite to verify that everything is working correctly:

```
$ rails test
```

Finally run the app on a local server:

```
$ rails server
```

## Teachers
* Log in as a teacher with username: 'teacher@example.com' / password: 'foobar'.
* If the user is teaching a course, the user will be presented with an option to 'drop' the course.
* If there is no teacher assigned to the course, the user will presented with the option to 'Sign up to teach.
* A teacher can visit a course page and the enrolled students and their grades for the course.

## Students

* A Student can see the courses he is registered for (with grades)
* A Student can see his GPA for a given semester

## Administrators

* An Administrator can view enrollment counts across all courses for a semester.
* An Administrator can view an average grade for a given course.


For more information, contact Bill Kohler bkohler4@gmail.com
