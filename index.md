---
layout: default
title: "courses.umn.edu"
---

# courses.umn.edu

A JSON/XML service for getting University of Minnesota course and class data. Works for all campuses. Searchable. Up to date.

Note this is still under active development. The links below will work, but our demo site only contains data for the Fall, 2014 term. More terms are coming later.

## Getting Courses

You probably want to retrieve courses using cURL/Wget/etc. The files can be quite large and browsers can get fussy about loading a 50 meg xml file.

You must include a Campus and Term. The format is:

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.json`

or, if you want XML:

`http://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.xml`

Some examples:

- [http://courses.umn.edu/campuses/umncr/terms/1163/courses.json](http://courses.umn.edu/campuses/umncr/terms/1163/courses.json)
- [http://courses.umn.edu/campuses/umnro/terms/1163/courses.xml](http://courses.umn.edu/campuses/umnro/terms/1163/courses.xml)

## What Campuses Are Available

- [http://courses.umn.edu/campuses.json](http://courses.umn.edu/campuses.json)
- [http://courses.umn.edu/campuses.xml](http://courses.umn.edu/campuses.xml)

## What Terms Are Available

- [http://courses.umn.edu/terms.json](http://courses.umn.edu/terms.json)
- [http://courses.umn.edu/terms.xml](http://courses.umn.edu/terms.xml)

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

#### Finding courses under one subject:

`courses.json?q=subject_id=HIST`

This will return all courses with the subject of HIST.

#### Finding courses under many subjects:

`courses.xml?q=subject_id=HIST|PHYS`

Returns all courses with a subject of HIST or PHYS. You can have as many subjects as you want, just separate them with a \|.

### Catalog Number

#### Find a course with a specific catalog number

`courses.json?q=catalog_number=1101W`

Returns all courses with a catalog number of '1101W'.

#### Find a course with a catalog number higher than a value:

`courses.xml?q=catalog_number>1000`

Returns all courses with a catalog number higher than 1000. 

You can also do `>=` to return courses with a catalog number higher than or equal to 1000

#### Find a course with a catalog number less than a value:

`courses.xml?q=catalog_number<5000`

Returns all courses with a catalog number less than 1000. 

You can also do `<=` to return courses with a catalog number less than or equal to 1000

#### Find courses with a catalog number in a range of values:

`courses.xml?q=catalog_number>=1000,catalog_number<5000`

Returns all courses with a catalog_number greater than or equal to 1000 and less than 5000

### Liberal Education / General Education

Different campuses have different ways of identifying courses that meet General Education or Liberal Education criteria. You can search for these by using the `course_attribute_family`:

- UMNTC's Liberal Education: `courses.json?q=course_attribute_family=CLE`
- UMNDL's Liberal Education: `courses.json?q=course_attribute_family=DLE`
- UMNRO's Liberal Education: `courses.json?q=course_attribute_family=GE`
- UMNMO's General Education: `courses.json?q=course_attribute_family=GER`

And if you're looking for a courses with a specific attribute, you can search with `course_attribute_id`

#### Get courses that satisfy UMNTC's Writing Intensive

`courses.json?q=course_attribute_id=WI`

#### Get courses that satisfy UMNRO's Mathematical Thinking

`courses.json?q=course_attribute_id=MATH%20THINK`

#### Get courses that meet either UMNDL's Fine Arts or Humanities

`courses.xml?q=course_attribute_id=FINE%20ARTS|HUMANITIES`

#### Get courses that have any attribute

`courses.xml?q=course_attribute_id=all`

#### Or that have no attribute

`courses.xml?q=course_attribute_id=none`

### Instruction Mode

You can search using any of these Instruction Mode abbreviations:

- P: In Person, Term Based
- ID: Independent/Directed Study
- CE: Online Distance Learning
- PA: Partially Online
- CO: Completely Online
- PR: Primarily Online

#### Get courses that are Partially Online

`courses.json?q=instruction_mode_id=PA`

#### Get courses that are Partially Online or Primarily Online

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

