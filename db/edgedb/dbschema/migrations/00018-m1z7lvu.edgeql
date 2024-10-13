CREATE MIGRATION m1z7lvuczzluv7k5lznfl3h55botpps4tvnzlsr2qxlxuclku4wsba
    ONTO m1ovq7enrjytcwvwbp5434qxanvvkls42fcdmmmowlois7rqopacyq
{
  ALTER TYPE default::Folder {
      ALTER PROPERTY path2 {
          USING (((.name ++ '/') ++ .<folders[IS default::Folder].name));
      };
  };
};
