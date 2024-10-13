CREATE MIGRATION m122osibwan46j3dictd5oxwvm57e3op4wtgfowcfpntj5apyezygq
    ONTO m1sij3l73abkrvmknmk5beligbrwwpbgqb62cbon77gl7y5dbquirq
{
  ALTER TYPE default::Folder {
      ALTER PROPERTY path2 {
          USING (((std::assert_single(.<folders[IS default::Folder].name) ++ '/') ++ .name));
      };
      ALTER PROPERTY path {
          USING (.path2);
      };
  };
};
