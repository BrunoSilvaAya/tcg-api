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


select * from "WaitlistEntries";


CREATE TYPE card_type AS ENUM ('Deity', 'Spirit', 'Ceremony', 'Legend', 'Artifact');
CREATE TYPE card_rarity AS ENUM ('Common', 'Uncommon', 'Rare');

CREATE TABLE collections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    total_cards INT NOT NULL DEFAULT 0,
    cover_image_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_id UUID NOT NULL REFERENCES collections(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    type card_type NOT NULL,
    rarity card_rarity NOT NULL,
    card_number INT NOT NULL,
    illustration_url TEXT,
    flavor_text TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE (collection_id, card_number)
);

CREATE INDEX idx_cards_collection_id ON cards(collection_id);
CREATE INDEX idx_cards_rarity ON cards(rarity);