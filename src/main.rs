extern crate iron;

use iron::prelude::*;
use iron::status;

fn index(_: &mut Request) -> IronResult<Response> {
    Ok(Response::with((status::Ok, "Hello, World!")))
}

fn main() {
    let chain = Chain::new(index);

    Iron::new(chain).http("0.0.0.0:3000")
        .map(|_| println!("listening on http://localhost:3000"))
        .map_err(|_| {
            println!("error")
        });
}
