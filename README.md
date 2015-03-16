# courses.umn.edu

## Getting Courses

You must include a Campus and Term. The format is:

`https://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.json`

or, if you want XML:

`https://courses.umn.edu/campuses/[campus abbreviation]/terms/[strm]/courses.xml`

Some examples:

- https://courses-staging.umn.edu/campuses/umntc/terms/1149/courses.json
- https://courses-staging.umn.edu/campuses/umnro/terms/1153/courses.xml

## Searching

Search for courses by using the query string. You can search by:

- Subject
- Catalog Number
- Liberal Education 
- Instruction Mode

Searching works with both JSON and XML output.

All of these searches can be combined, as we'll see in the examples.

### Subject

Finding courses under one subject:

`courses.json?q=subject=HIST`

This will return all courses with the subject of HIST.

----

Finding courses under many subjects:

`courses.xml?q=subject=HIST|PHYS`

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

`courses.xml?q=catalog_number>=1000&catalog_number<5000`

Returns all courses with a catalog_number greater than or equal to 1000 and less than 5000

### Liberal Education

Get courses that are Writing Intensive

`courses.json?q=cle_attributes=WI`

---

Get courses that meet Civic Life or Historical Perspectives

`courses.xml?q=cle_attributes=HIS|CIV`

### Instruction Mode

You can search using any of these Instruction Mode abbreviations:


- P: In Person, Term Based
- ID: Independent/Directed Study
- CE: Online Distance Learning
- PA: Partially Online
- CO: Completely Online
- PR: Primarily Online

Get courses that are Partially Online

`courses.json?q=instruction_mode=PA`

----

Get courses that are Partially Online or Primarily Online

`courses.xml?q=instruction_mode=PA|PR`

### Combining Searches

Any of the searches can be combined. For example:

`courses.json?q=cle_attributes=WI&instruction_mode=P&catalog_number>=2000&catalog_number<3000&subject=HIST`

Will return any courses that are:

- Writing Intensive
- Taught In Person
- With a catalog number between 2000 and 2999
- In the history department
