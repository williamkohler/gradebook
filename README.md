# Gradebook

A gradebook application for teachers students and administrators to manage courses.

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

* Log in as a student with username: 'student@example.com' / password: 'foobar'.
* When a student logs in they will see their GPA.
* The student will also see a list of  courses they are enrolled in and their grade for the course.

## Administrators

* Log in as an administrator with username: 'admin@example.com' / password: 'foobar'.
* The administrator can view all courses with the course's enrollment count.
* Administrators will also see a course's average grade.


## Questions?

For more information, contact Bill Kohler bkohler4@gmail.com
