CREATE MIGRATION m1qa5366lpgbsa5svgvodjxc5v2z7paock7oybebsc3l77vmqiycyq
    ONTO m1myjuc7mrbgkbdkpuutgg2idnmnfq6byzhtmoanvkeaasds23q4ta
{
  ALTER TYPE default::File {
      ALTER PROPERTY path {
          USING ({.<files[IS default::Folder].path});
      };
  };
};
