CREATE MIGRATION m1sij3l73abkrvmknmk5beligbrwwpbgqb62cbon77gl7y5dbquirq
    ONTO m1c3ei2vaysaxu53giogq4rcosux5p7lmb2vzthxuu6scrah323cdq
{
  ALTER TYPE default::Folder {
      ALTER PROPERTY path2 {
          USING (((std::assert_single(.folders[IS default::Folder].name) ++ '/') ++ .name));
      };
  };
};
