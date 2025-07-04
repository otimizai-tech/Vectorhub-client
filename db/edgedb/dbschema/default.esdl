module default {

  global current_collection_id: uuid;
  global current_collection_name: str;


  type Collection {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    required name: str;
    description: str;

    multi dashbord: Dashbord {
      on target delete allow;
      on source delete delete target;
  };
    multi tags: Tag {
      on target delete allow;
      on source delete delete target;
  };
    multi folders: Folder {
      on target delete allow;
      on source delete delete target;
  };
    multi files: File {
      on target delete allow;
      on source delete delete target;
  }

    multi chats: Chat {
      on target delete allow;
      on source delete delete target;
  }
    multi prompts: Prompt {
      on target delete allow;
      on source delete delete target;
  }
   multi databases: DataBaseHub {
      on target delete allow;
      on source delete delete target;
   }
   multi chunks: Chunk {
      on target delete allow;
      on source delete delete target;
   }

    metadata: json;


  }


  type Prompt {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    name: str;

    tags: str;
    description: str;
    metadata: json;

    content: str;

    multi X_prompt: Prompt {
      on target delete allow;
  }
    multi X_tag: Tag {
      on target delete allow;
  }
    multi X_dashbord: Dashbord {
      on target delete allow;
  }

  multi X_folder: Folder {
      on target delete allow;
  }
  multi X_file: File {
      on target delete allow;
  }




    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<prompts[is Collection].id)
      or global current_collection_name ?= assert_single(.<prompts[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<prompts[is Collection].id)
      or global current_collection_name ?= assert_single(.<prompts[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<prompts[is Collection].id)
      or global current_collection_name ?= assert_single(.<prompts[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      prompts += __new__
    }
  );

  }




  type Folder {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    isEnabled: bool {
      default:= true
    }


    required name: str;
    description: str;
    path: str;

    multi folders : Folder {
      on target delete allow;
      on source delete delete target;
  };
    multi files : File {
      on target delete allow;
      on source delete delete target;
  };

  

    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<folders[is Collection].id)
      or global current_collection_name ?= assert_single(.<folders[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<folders[is Collection].id)
      or global current_collection_name ?= assert_single(.<folders[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<folders[is Collection].id)
      or global current_collection_name ?= assert_single(.<folders[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      folders += __new__
    }
  );

    trigger update_is_enable_files after update for each 
    when (__new__.isEnabled != __old__.isEnabled)
    do (
    update __old__.files
    set {
      isEnabled := __new__.isEnabled
    }
  );


  }


  type File {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    isEnabled: bool {
      default:= true
    }

    required name: str;
    path:= {
      ((select .<files[is Folder].path limit 1) ++ "/" ++ .name)
    };
    description: str;


    file: Chunk {
      on target delete allow;
      on source delete delete target;
  };

    multi chunks: Chunk {
      on target delete allow;
      on source delete delete target;
  };



    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<files[is Collection].id)
      or global current_collection_name ?= assert_single(.<files[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<files[is Collection].id)
      or global current_collection_name ?= assert_single(.<files[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<files[is Collection].id)
      or global current_collection_name ?= assert_single(.<files[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      files += __new__
    }
  );

    trigger update_is_enable_chunks after update for each 
    when (__new__.isEnabled != __old__.isEnabled)
    do (
    update __old__.chunks
    set {
      isEnabled := __new__.isEnabled
    }
  );



  }


  type DataBaseHub {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    name: str;
    emb_model: str;

    config: json;
    contentType: str;

    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<databases[is Collection].id)
      or global current_collection_name ?= assert_single(.<databases[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<databases[is Collection].id)
      or global current_collection_name ?= assert_single(.<databases[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<databases[is Collection].id)
      or global current_collection_name ?= assert_single(.<databases[is Collection].name));
      
    access policy acess_collection_i
    allow insert
    using (.id ?= .id);

    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      databases += __new__
    }
  );


  }


  type Chunk {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    multi database: DataBaseHub {
      on target delete allow;
  };

    content: str {
      default:= ""
    }

    contentType: str;

    multi tags: Tag {
      on target delete allow;
  };

    old_id: str;

    payload: json {
      default:= to_json("{}")
    }
    isEnabled: bool {
      default:= False
    }
    multi X_ref: Chunk {
      on target delete allow;
  };

  modified: datetime {
    default:= datetime_current();
    rewrite insert, update using ( datetime_current());
  }




    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<chunks[is Collection].id)
      or global current_collection_name ?= assert_single(.<chunks[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<chunks[is Collection].id)
      or global current_collection_name ?= assert_single(.<chunks[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<chunks[is Collection].id)
      or global current_collection_name ?= assert_single(.<chunks[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      chunks += __new__
    }
  );

  }



  type Tag {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    name: str;
    multi chunks:= .<tags[is Chunk];


    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<tags[is Collection].id)
      or global current_collection_name ?= assert_single(.<tags[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<tags[is Collection].id)
      or global current_collection_name ?= assert_single(.<tags[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<tags[is Collection].id)
      or global current_collection_name ?= assert_single(.<tags[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      tags += __new__
    }
  );

  }

  type Dashbord {
    required X_alias: str {
      default:= <str>uuid_generate_v4();
    } 

    name: str {
      default:= "dashboard"
    };
    description: str {
      default:= "Dashboard"
    };

    multi tags: Tag {
      on target delete allow;
  };

    multi chats: Chat {
      on target delete allow;
      on source delete delete target;
  };


    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<dashbord[is Collection].id)
      or global current_collection_name ?= assert_single(.<dashbord[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<dashbord[is Collection].id)
      or global current_collection_name ?= assert_single(.<dashbord[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<dashbord[is Collection].id)
      or global current_collection_name ?= assert_single(.<dashbord[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      dashbord += __new__
    }
  );

  }

  type Chat {

    history: str;

    access policy acess_collection_s
    allow select
    using (
      global current_collection_id ?= assert_single(.<chats[is Collection].id)
      or global current_collection_name ?= assert_single(.<chats[is Collection].name));

    access policy acess_collection_d
    allow delete
    using (
      global current_collection_id ?= assert_single(.<chats[is Collection].id)
      or global current_collection_name ?= assert_single(.<chats[is Collection].name));

    access policy acess_collection_u
    allow update
    using (
      global current_collection_id ?= assert_single(.<chats[is Collection].id)
      or global current_collection_name ?= assert_single(.<chats[is Collection].name));

    access policy acess_collection_i
    allow insert
    using (.id ?= .id);


    trigger insert_in_collection after insert for each do (
    update Collection 
    filter .id = global current_collection_id
    set {
      chats += __new__
    }
  );

  }


FUNCTION  parse_chunks(data: Chunk) -> json
USING EdgeQL $$
select <json>(
    select data {
      ID_a:= data.id,
      ID:= data.X_alias,
      modified:= data.modified,
      payload:= (<json>(
        pageContent:= data.content ?? "",
        system_metadata:= {
            dashboard_on:= DISTINCT data.tags.<tags[is Dashbord].name,
            database_name:= data.database.name,
            tags_name:=  data.tags.name,
            X_ID := data.X_ref.X_alias, 
            as_X_ID := data.<X_ref[is Chunk].X_alias, 
            path:=  ( select DISTINCT  (data.<chunks[is File].path) limit 1 ),
            filename:=  ( select DISTINCT (data.<chunks[is File].name) limit 1 ),
            isEnabled := data.isEnabled,
        },
        metadata:= data.payload
      ) ) ?? to_json("{}")
    }
  )
$$;
};
