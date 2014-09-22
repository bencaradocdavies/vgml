-- ported from mysql

drop table jobs;
drop table series;
drop table jobs_audit_log;
drop table downloads;
drop table parameters;
drop table signatures;

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

create table "downloads" (
    "id" serial primary key,
    "jobid" integer not null,
    "url" text not null,
    "localpath" text not null,
    "name" text,
    "description" text,
    "northboundlatitude" float,
    "southboundlatitude" float,
    "eastboundlongitude" float,
    "westboundlongitude" float
);
create index "idx_downloads_jobid" on "downloads" ("jobid");

create table "parameters" (
    "id" serial primary key,
    "jobid" integer not null,
    "name" text not null,
    "value" text,
    "type" text not null
);
create index "idx_parameters_jobid" on "parameters" ("jobid");

create table "signatures" (
    "id"  serial primary key,
    "user" text not null,
    "individualname" text,
    "organisationname" text,
    "positionname" text,
    "telephone" text,
    "facsimile" text,
    "deliverypoint" text,
    "city" text,
    "administrativearea" text,
    "postalcode" text,
    "country" text,
    "onlinecontactname" text,
    "onlinecontactdescription" text,
    "onlinecontacturl" text,
    "keywords" text,
    "constraints" text
);
create index "idx_signatures_user" on "signatures" ("user");
