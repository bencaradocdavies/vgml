-- ported from mysql

drop table jobs;
drop table series;
drop table jobs_audit_log;

create table "series" (
  "id" serial primary key,
  "user" text not null,
  "name" text not null,
  "description" text
);
create index "idx_series_user" on "series" ("user");

create table "jobs" (
    "id" serial primary key,
    "name" text,
    "description" text,
    "emailaddress" text,
    "user" text,
    "submitdate" timestamp,
    "status" text,
    "computevmid" text,
    "computeinstanceid" text,
    "computeinstancetype" text,
    "computeinstancekey" text,
    "registeredurl" text,
    "seriesid" integer,
    "storagebasekey" text,
    "computeserviceid" text,
    "storageserviceid" text,
    "processdate" timestamp,
    "emailnotification" text default 'N',
    "processtimelog" text default ''
);
create index "idx_job_emailaddress" on "jobs" ("emailaddress");
create index "idx_job_user" on "jobs" ("user");
create index "idx_job_seriesid" on "jobs" ("seriesid");

create table "jobs_audit_log" (
    "id" serial primary key,
    "jobid" integer,
    "fromstatus" text,
    "tostatus" text,
    "transitiondate" timestamp,
    "message" text
);
create index "idx_jobs_audit_log_jobid" on "jobs_audit_log" ("jobid");
