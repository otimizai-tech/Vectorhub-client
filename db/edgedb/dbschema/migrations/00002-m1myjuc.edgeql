CREATE MIGRATION m1myjuc7mrbgkbdkpuutgg2idnmnfq6byzhtmoanvkeaasds23q4ta
    ONTO m1z3r6lelgguvs76dlmtfzdhqwjba77lzcnp66hfoh6axglqdumdza
{
  ALTER TYPE default::DataBaseHub {
      ALTER ACCESS POLICY acess_collection_u USING (true);
  };
};
