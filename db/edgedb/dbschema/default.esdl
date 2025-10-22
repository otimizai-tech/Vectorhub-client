using extension pgcrypto;


module default {

  global current_collection_id: uuid;
  global current_collection_name: str;


type Alias_name {
  required name: str { constraint exclusive; }          # alias único globalmente
  required link collection: Collection {
    on target delete delete source;                     # apagar a collection apaga o alias
  }
}

type Collection {
  required X_alias: str {
    default := <str>uuid_generate_v4();
  }

  required name: str {
    # nome da collection também é único
    constraint exclusive;
  }

  description: str;
  multi dashbord: Dashbord {
    on target delete allow;
    on source delete delete target;
  }
  multi tags: Tag {
    on target delete allow;
    on source delete delete target;
  }
  multi folders: Folder {
    on target delete allow;
    on source delete delete target;
  }
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

  # backlink só para consulta: todos os aliases desta Collection
  multi aliases := .<collection[is Alias_name];
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


    trigger insert_in_collection after insert for all do (
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


    trigger insert_in_collection after insert for all do (
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


    trigger insert_in_collection after insert for all do (
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

    trigger insert_in_collection after insert for all do (
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
    rewrite insert using ( datetime_current());
  }

  # Hash do conteúdo atual (bytes). Recalcula automático em insert/update.
  required content_hash: bytes {
    default := ext::pgcrypto::digest((.content ?? ''), 'sha256');
    rewrite insert, update using (
      ext::pgcrypto::digest((.content ?? ''), 'sha256')
    );
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


    trigger insert_in_collection after insert for all do (
    update Collection 
    filter .id = global current_collection_id
    set {
      chunks += __new__
    }
  );

 # << NOVO >>: guarda APENAS a última versão anterior via upsert
  trigger keep_prev_version
  after update for each 
  when ( __new__.content_hash != __old__.content_hash) 
  do (

        insert ChunkVersion {
          trash:=      (__old__.<chunk[is ChunkVersion]),
          ts           := datetime_current(),
          content      := (__old__.content ?? ''),
          content_hash := __old__.content_hash,
          contentType  := __old__.contentType,
          payload      := __old__.payload,
          chunk        := __new__   # << AQUI ESTAVA SEU ERRO
        }

    )
}





# # -------------------------
# # CHUNKVERSION (última versão anterior somente)
# # -------------------------
type ChunkVersion {

  required ts: datetime { default := datetime_current(); }
  content: str;
  content_hash: bytes;
  contentType: str;
  payload: json { default := to_json("{}"); }
  # Queremos: no máximo 1 ChunkVersion apontando para cada Chunk
  single chunk: Chunk {
    on target delete delete source;
    # constraint exclusive
  }

  multi trash: ChunkVersion {
    on source delete delete target;
    on target delete allow;
  };

  trigger erase
  after insert for all 
  do (
        # with
        # a:= (select count(ChunkVersion)),
        # b:= ( update bucket set {log_count_ChunkVersion:= a})

        delete __new__.trash

    # select {
    #   # _cont:= (update bucket set { log_count_ChunkVersion :=( select count(ChunkVersion))} ),
    #   del:= (
    #     )
    #   }
    )

  # access policy cv_select
  # allow select
  # using (
  #   global current_collection_id ?= assert_single(.chunk.<chunks[is Collection].id)
  #   or global current_collection_name ?= assert_single(.chunk.<chunks[is Collection].name)
  # );

  # access policy cv_write
  # allow insert, update
  # using (
  #   global current_collection_id ?= assert_single(.chunk.<chunks[is Collection].id)
  #   or global current_collection_name ?= assert_single(.chunk.<chunks[is Collection].name)
  # );
}

type bucket {
  log_count_ChunkVersion : int16; #{rewrite insert, update using (select count(ChunkVersion))}

  trigger erase
  after update for all 
  when (__new__.log_count_ChunkVersion > 2)
  do (
    with
    a:= (select ChunkVersion order by .ts desc offset 1 limit 2).id,

    delete ChunkVersion filter not .id in a
    )

}




type ApprovedToken {
    # required property not_before -> datetime;     # quando passa a valer
    # optional property reason -> str;
    # index on (.user);
    required jti : uuid ;
    required token : str;
    required issued_at : datetime { default := datetime_current(); };
    required expires_at : datetime;     # quando deixa de valer
    # required property revoked -> bool { default := false; }
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


    trigger insert_in_collection after insert for all do (
    update Collection 
    filter .id = global current_collection_id
    set {
      tags += __new__
    }
  );
  #   # NOVO gatilho: deduplicar por (name, Collection) após insert/update
  # trigger dedupe_tags after insert, update for each do (
  #   with
  #     # todas as tags com o mesmo nome nessa coleção
  #     same := (
  #       select Tag
  #       filter .name = __new__.name
  #       # and coll in .<tags[is Collection]
  #       # order by .id
  #     ),

  #     keep := __new__,
  #     dups := (select same filter .id != keep.id),

  #   # 1) reatribui chunks das duplicadas para a tag mantida
  #   c1 := (
  #     update dups.chunks
  #     set {
  #       tags += keep
  #     }
  #   ),

  #   # 2) apaga as duplicadas
  #   delete Tag filter .id in (select dups.id)
  # );

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


    trigger insert_in_collection after insert for all do (
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


    trigger insert_in_collection after insert for all do (
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
