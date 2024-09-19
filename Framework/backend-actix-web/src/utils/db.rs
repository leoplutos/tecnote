use rusqlite::Result;
use serde::{Deserialize, Serialize};
use std::error::Error;
use tracing::instrument;

// Login表
#[derive(Debug, Serialize, Deserialize)]
pub struct Login {
    pub userid: String,
    pub password: String,
}

// Todo表
#[derive(Debug, Serialize, Deserialize)]
#[allow(non_snake_case)]
pub struct Todo {
    pub todoId: i32,
    pub todoName: String,
    pub image: String,
    pub studied: bool,
}

// 内存数据库初始化
#[instrument]
pub async fn init_db_async() -> Result<(), Box<dyn Error>> {
    //在lazy_static中取得全局数据库连接
    let binding = crate::DB.lock().unwrap();
    let conn = &mut binding.as_ref().unwrap();

    conn.execute(
        "CREATE TABLE IF NOT EXISTS login(
            userid TEXT PRIMARY KEY NOT NULL,
            password TEXT NOT NULL
        )",
        (), // empty list of parameters.
    )?;
    let me = Login {
        userid: "admin".to_string(),
        password: "123".to_string(),
    };
    conn.execute(
        "INSERT INTO login (userid, password) VALUES (?1, ?2)",
        (&me.userid, &me.password),
    )?;

    conn.execute(
        "CREATE TABLE IF NOT EXISTS todo(
            todoid INT PRIMARY KEY NOT NULL,
            todoname TEXT,
            image TEXT,
            studied BOOLEAN
        )",
        (), // empty list of parameters.
    )?;
    let todo = Todo {
        todoId: 1,
        todoName: "Vue".to_string(),
        image: "./img/vue.png".to_string(),
        studied: false,
    };
    conn.execute(
        "INSERT INTO todo (todoid, todoname, image, studied) VALUES (?1, ?2, ?3, ?4)",
        (&todo.todoId, &todo.todoName, &todo.image, &todo.studied),
    )?;
    let todo = Todo {
        todoId: 2,
        todoName: "数据库".to_string(),
        image: "./img/database.png".to_string(),
        studied: false,
    };
    conn.execute(
        "INSERT INTO todo (todoid, todoname, image, studied) VALUES (?1, ?2, ?3, ?4)",
        (&todo.todoId, &todo.todoName, &todo.image, &todo.studied),
    )?;
    let todo = Todo {
        todoId: 3,
        todoName: "Python".to_string(),
        image: "./img/python.png".to_string(),
        studied: false,
    };
    conn.execute(
        "INSERT INTO todo (todoid, todoname, image, studied) VALUES (?1, ?2, ?3, ?4)",
        (&todo.todoId, &todo.todoName, &todo.image, &todo.studied),
    )?;
    let todo = Todo {
        todoId: 4,
        todoName: "Golang".to_string(),
        image: "./img/go.png".to_string(),
        studied: false,
    };
    conn.execute(
        "INSERT INTO todo (todoid, todoname, image, studied) VALUES (?1, ?2, ?3, ?4)",
        (&todo.todoId, &todo.todoName, &todo.image, &todo.studied),
    )?;

    /*
    let mut stmt = conn.prepare("SELECT * FROM login")?;
    let login_iter = stmt.query_map([], |row| {
        Ok(Login {
            userid: row.get(0)?,
            password: row.get(1)?,
        })
    })?;

    for login in login_iter {
        println!("Found login {:?}", login.unwrap());
    }

    let mut stmt = conn.prepare("SELECT * FROM todo")?;
    let todo_iter = stmt.query_map([], |row| {
        Ok(Todo {
            todoid: row.get(0)?,
            todoname: row.get(1)?,
            image: row.get(2)?,
            studied: row.get(3)?,
        })
    })?;

    for todo in todo_iter {
        println!("Found todo {:?}", todo.unwrap());
    }
    */
    Ok(())
}
