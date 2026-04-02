-- TCG API - Initial Database Creation

CREATE TABLE IF NOT EXISTS "Users" (
    "Id"         SERIAL PRIMARY KEY,
    "GoogleId"   VARCHAR(255) NOT NULL,
    "Email"      VARCHAR(255) NOT NULL,
    "Name"       VARCHAR(255) NOT NULL,
    "PictureUrl" TEXT,
    "CreatedAt"  TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc'),
    CONSTRAINT "UQ_Users_GoogleId" UNIQUE ("GoogleId"),
    CONSTRAINT "UQ_Users_Email"    UNIQUE ("Email")
);

CREATE TABLE IF NOT EXISTS "WaitlistEntries" (
    "Id"           SERIAL PRIMARY KEY,
    "Email"        VARCHAR(255) NOT NULL,
    "SignedUpAt"   TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc'),
    "IsNotified"   BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT "UQ_WaitlistEntries_Email" UNIQUE ("Email")
);
