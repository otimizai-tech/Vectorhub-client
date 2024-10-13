CREATE MIGRATION m1ovq7enrjytcwvwbp5434qxanvvkls42fcdmmmowlois7rqopacyq
    ONTO m1oocxr63dcuhdxq3coyqjveayodru3r5n73isu4krgjtnkbfdxuoq
{
  ALTER TYPE default::Chunk {
      CREATE PROPERTY tags := (.<X_ref[IS default::Tag].name);
  };
  CREATE TYPE default::DataBaseHub {
      CREATE PROPERTY emb_model: std::str;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Folder {
      CREATE PROPERTY path2 := ((.<folders[IS default::Folder].name ++ .name));
  };
};
