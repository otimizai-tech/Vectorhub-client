CREATE MIGRATION m1c3ei2vaysaxu53giogq4rcosux5p7lmb2vzthxuu6scrah323cdq
    ONTO m1z7lvuczzluv7k5lznfl3h55botpps4tvnzlsr2qxlxuclku4wsba
{
  ALTER TYPE default::Folder {
      ALTER PROPERTY path2 {
          USING (((.<folders[IS default::Folder].name ++ '/') ++ .name));
      };
  };
};
