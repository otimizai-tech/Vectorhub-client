CREATE MIGRATION m1clo27sxgdvoqd23hoxac4ngtuf7z74zhuho55kr4sewabol6kd7a
    ONTO m1qa5366lpgbsa5svgvodjxc5v2z7paock7oybebsc3l77vmqiycyq
{
  ALTER TYPE default::File {
      ALTER PROPERTY path {
          USING ({((.<files[IS default::Folder].path ++ '/') ++ .name)});
      };
  };
};
