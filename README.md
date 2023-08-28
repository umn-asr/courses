# courses.umn.edu

A JSON/XML service for getting University of Minnesota course and class data. Works for all campuses. Searchable. Up to date.

## Table of Contents

* [Development](#development)
  + [Setup](#setup)
  + [Run tests](#run-tests)
  + [Deployment](#deployment)
  + [Open a Rails console](#open-a-rails-console)
* [URLs](#urls)
* [Getting Courses](#getting-courses)
* [Courses vs Classes](#courses-vs-classes)
* [Documentation](#documentation)
* [Searching](#searching)
  + [Subject](#subject)
  + [Catalog Number](#catalog-number)
  + [Liberal Education / General Education](#liberal-education---general-education)
  + [Instruction Mode](#instruction-mode)
  + [Location](#location)
  + [Combining Searches](#combining-searches)
* [Owners](#owners)

## Development

### Setup

1. Clone this repo
1. Run `./script/setup`

### Run tests

Run `./script/test`

### Server

Run `./script/server` to start up a local Rails server

### Deployment

Run `./script/deploy [ENV]`

### Open a Rails console

Run `./script/console`

## URLs

- Homepage: https://asr-custom.umn.edu/courses/

## Getting Courses

You probably want to retrieve courses using cURL/Wget/etc. The files can be quite large and browsers can get fussy about loading a 50 meg xml file.

You must include a Campus and Term. The format is:

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.json`

or, if you want XML:

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.xml`

Some examples:

- https://courses.umn.edu/campuses/umncr/terms/1203/courses.json
- https://courses.umn.edu/campuses/umncr/terms/1203/courses.json

## Courses vs Classes

This service can provide you data for Courses or Classes. Classes are things you can actually enroll for, wheras a Course is something that may or may not be offered that term.

If you're not sure, you probably want to look at Classes.

To view Classes data, use 

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/classes.json`
`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/classes.xml`

To view Course data, use 

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.json`
`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.xml`

All of the documentation below applies equally to Courses and Classes.

## Documentation

We have documentation about the data you'll find in [doc/resources](https://github.com/umn-asr/courses/tree/main/doc/resources).

For Courses, you'll probably want to start with [courses.yml](https://github.com/umn-asr/courses/blob/main/doc/resources/courses.yml).

For Classes, you'll probably want to start with [courses.yml](https://github.com/umn-asr/courses/blob/main/doc/resources/courses.yml).

## Searching

Search for courses by using the query string. You can search by:

- Subject
- Catalog Number
- Liberal Education
- Instruction Mode
- Location

Searching works with both JSON and XML output.

All of these searches can be combined, as we'll see in the examples.

### Subject

Finding courses under one subject:

`courses.json?q=subject_id=HIST`

This will return all courses with the subject of HIST.

----

Finding courses under many subjects:

`courses.xml?q=subject_id=HIST|PHYS`

Returns all courses with a subject of HIST or PHYS. You can have as many subjects as you want, just separate them with a |.

### Catalog Number

Find a course with a specific catalog number

`courses.json?q=catalog_number=1101W`

Returns all courses with a catalog number of '1101W'.

----

Find a course with a catalog number higher than a value:

`courses.xml?q=catalog_number>1000`

Returns all courses with a catalog number higher than 1000. 

You can also do `>=` to return courses with a catalog number higher than or equal to 1000

----

Find a course with a catalog number less than a value:

`courses.xml?q=catalog_number<5000`

Returns all courses with a catalog number less than 1000. 

You can also do `<=` to return courses with a catalog number less than or equal to 1000

---

Find courses with a catalog number in a range of values:

`courses.xml?q=catalog_number>=1000,catalog_number<5000`

Returns all courses with a catalog_number greater than or equal to 1000 and less than 5000

### Liberal Education / General Education

Different campuses have different ways of identifying courses that meet General Education or Liberal Education criteria. You can search for these by using the `course_attribute_family`:

- UMNTC's Liberal Education: `courses.json?q=course_attribute_family=CLE`
- UMNDL's Liberal Education: `courses.json?q=course_attribute_family=DLE`
- UMNRO's Liberal Education: `courses.json?q=course_attribute_family=GE`
- UMNMO's General Education: `courses.json?q=course_attribute_family=GER`

And if you're looking for a courses with a specific attribute, you can search with `course_attribute_id`

Get courses that satisfy UMNTC's Writing Intensive

`courses.json?q=course_attribute_id=WI`

Get courses that satisfy UMNRO's Mathematical Thinking

`courses.json?q=course_attribute_id=MATH%20THINK`

Get courses that meet either UMNDL's Fine Arts or Humanities

`courses.xml?q=course_attribute_id=FINE%20ARTS|HUMANITIES

Get courses that have any attribute

`courses.xml?q=course_attribute_id=all`

Or that have no attirbute

`courses.xml?q=course_attribute_id=none`

### Instruction Mode

You can search using any of these Instruction Mode abbreviations:

- P: In Person, Term Based
- ID: Independent/Directed Study
- CE: Online Distance Learning
- PA: Partially Online
- CO: Completely Online
- PR: Primarily Online

Get courses that are Partially Online

`courses.json?q=instruction_mode_id=PA`

----

Get courses that are Partially Online or Primarily Online

`courses.xml?q=instruction_mode_id=PA|PR`

### Location

Search for courses with at least one section in the location you specifiy

`courses.xml?q=locations=TCWESTBANK`

or

`courses.json?q=locations=OFFCMPROCH`

### Combining Searches

Any of the searches can be combined. For example

`courses.json?q=course_attribute_id=WI,instruction_mode_id=P,catalog_number>=2000,catalog_number<3000,subject_id=HIST`

Will return any courses that are:

- Writing Intensive
- Taught In Person
- With a catalog number between 2000 and 2999
- Have the subject HIST

## Owners

Who is responsible for the web application after initial development?
 * [See this spreadsheet](https://docs.google.com/spreadsheets/d/1JOCG2MZnzsQ_ja8B-pEBqARSXyvoR0TwDb_APO3cdL4/edit?usp=sharing).
