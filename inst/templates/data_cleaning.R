# Clean data for {{{report_month}}} {{{report_year}}}

library(tidyverse)
library(lubridate)
library(readxl)
library(kableExtra)
library(janitor)
library(assertr)
library(stringr)


######### ENTER LOCATION OF DATABASES #########
projects_location <-


grant_location <-
##############################################

# Check 1: Does the projects data contain the sheets "Client Work" and "Client Projects" --------------------------
project_sheet_names <- excel_sheets(projects_location)

stopifnot('Client Work' %in% project_sheet_names)
stopifnot('Client Projects' %in% project_sheet_names)


# Step 1: Extract projects and work done on those projects into two tibbles --------------------------

projects <-
  readxl::read_xlsx(path = projects_location, sheet = 'Client Projects') %>%
  mutate(type = 'SAS')

project_work <-
  readxl::read_xlsx(path = projects_location, sheet = 'Client Work') %>%
  mutate(type = 'SAS')

# Check 2: Does the grants data contain the sheets "Client Work" and "Client Grants" --------------------------
grant_sheet_names <- excel_sheets(grant_location)

stopifnot('Client Work' %in% grant_sheet_names)
stopifnot('Client Grants' %in% grant_sheet_names)

# Step 2: Extract grants and work done on those grants into two tibbles --------------------------

grants <-
  readxl::read_xlsx(path = grant_location, sheet = 'Client Grants') %>%
  mutate(type = 'GRANT')

grant_work <-
  readxl::read_xlsx(path = grant_location, sheet = 'Client Work') %>%
  mutate(type = 'GRANT')


# Step 3:  Select out columns I want from each grant and project tibble
grant_metadata <-
  grants %>%
  select(
    GrantID,
    FirstName,
    LastName,
    GrantAgency,
    WorkRequested,
    Division,
    DOMLevel,
    Collaborator,
    PGYNom
  )

project_metadata <-
  projects %>%
  select(
    ProjectID,
    FirstName,
    LastName,
    WorkRequested,
    Division,
    DOMLevel,
    Collaborator,
    PGYNom
  )

# Step 4: Combine the data into a single dataframe.

grant_work_temp <- grant_work %>%
  left_join(grant_metadata) %>%
  mutate(Name = stringr::str_c(FirstName, LastName, sep = '_')) %>%
  select(
    Name,
    type,
    WorkHrs,
    GrantID,
    WorkDate,
    WorkHrs,
    GrantAgency,
    WorkRequested,
    Division,
    DOMLevel,
    Collaborator,
    PGYNom
  ) %>%
  rename(ID = GrantID)

project_work_temp <-
  project_work %>%
  left_join(project_metadata) %>%
  mutate(Name = stringr::str_c(FirstName, LastName, sep = '_')) %>%
  select(
    Name,
    type,
    WorkHrs,
    ProjectID,
    WorkDate,
    WorkHrs,
    WorkRequested,
    Division,
    DOMLevel,
    Collaborator,
    PGYNom
  ) %>%
  rename(ID = ProjectID)

#The work table below is what we will be summarizing.
#Every summary must come from this table.
#The table includes all the work done since program inception.
#The grant table does not have a date for services requested,
#so as a proxy we can use date of first work done for date of request.
#This shouldn't be a big deal in practice.  There may be a few times when work is requested at the end
#of one month but we start at another, but these should be few and far between and do not
#give a noticeably different result.
#The simplicity of the approach is worth any discrepancies in my opinion.
work = bind_rows(grant_work_temp, project_work_temp)


# Save clean data--------------------
saveRDS(
  work,
  here::here(
    "reports",
    "{{{ report_year }}}",
    "{{{ report_month }}}",
    "delays_{{{ report_month }}}_{{{ report_year }}}_clean.rds"
  )
)
