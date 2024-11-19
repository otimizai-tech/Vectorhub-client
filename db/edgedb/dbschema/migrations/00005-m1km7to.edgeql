CREATE MIGRATION m1km7tojndh3j3n4q3ahk6rumaisg7rhztea73rgq5lhme3zpipxnq
    ONTO m1clo27sxgdvoqd23hoxac4ngtuf7z74zhuho55kr4sewabol6kd7a
{
  ALTER TYPE default::File {
      ALTER PROPERTY path {
          USING ({(((SELECT
              .<files[IS default::Folder].path 
          LIMIT
              1
          ) ++ '/') ++ .name)});
      };
  };
};
