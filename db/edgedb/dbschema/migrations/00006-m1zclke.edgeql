CREATE MIGRATION m1zclkeghskusvsprindlkrsqytdr7pavux7zuyimkeuhp3ijp6iaa
    ONTO m1haypfgpzhrlz5b6xrwtag67lqjqmndyhqqdsgl5m46rcndzuqf3a
{
  ALTER TYPE default::chunk RENAME TO default::Chunk;
  ALTER TYPE default::chunks_holder RENAME TO default::Chunks_holder;
  ALTER TYPE default::collection RENAME TO default::Collection;
  ALTER TYPE default::Collection {
      CREATE PROPERTY metadata: std::json;
  };
  ALTER TYPE default::dashbord RENAME TO default::Dashbord;
};
