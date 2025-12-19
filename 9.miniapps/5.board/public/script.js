// 1. 이 파일 즉 이 페이지가 최초로 불릴때, 게시판에 글이 있을수도 있으니 로딩하기
document.addEventListener("DOMContentLoaded", () => {
    fetch("/api/list")
        .then((res) => res.json())
        .then((data) => {
            console.log(data); // 아마도 []
            data.forEach((post) => makeCard(post.id, post.title, post.message));
        });
});

function makeCard(id, title, message) {
    // DOM 위치 가져오기
    // DOM 생성하기
    // 기존에 있던 DOM의 차일드에 추가하기
    const card = document.createElement("div");
    card.innerHTML = `
        <div class="card mb-3" id="card_${id}">
            <div class="card-body">
                <p class="card-id text-muted">ID: ${id}</p>
                <div class="content-area">
                    <h5 class="card-title">${title}</h5>
                    <p class="card-text">${message}</p>
                </div>
                <button class="btn btn-info modify-btn">수정</button>
                <button class="btn btn-warning delete-btn">삭제</button>
            </div>
        </div>
    `;
    document.getElementById("card-list").appendChild(card);

    // 이벤트 리스너 연결
    const modifyBtn = card.querySelector(".modify-btn");
    modifyBtn.addEventListener("click", () => modifyPost(id, modifyBtn));

    card.querySelector(".delete-btn").addEventListener("click", () =>
        deletePost(id)
    );
}

function uploadPost() {
    // 프런트에서 부른건 uploadPost() 였음
    // DOM 에서 입력한 글자들 가져오기...
    // fetch(글쓰기)
    //    .then(성공확인)
    //    .then(불러오기(=카드만들기))

    const title = document.getElementById("input-title").value;
    const message = document.getElementById("input-text").value;

    fetch("/api/create", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title, message }),
    })
        .then((res) => res.json())
        .then((data) => {
            if (data.result == "success") {
                alert("저장 완료");
                location.reload(); // 이 페이지 통째로 새로 부르기
            } else {
                alert("저장 실패");
            }
        });
}

function deletePost(id) {
    // fetch(글삭제)
    //     .then(성공확인)
    //     .then(불러오기(=카드만들기))

    fetch(`/api/delete/${id}`, {
        method: "DELETE",
    })
        .then((res) => res.json())
        .then((data) => {
            if (data.result == "success") {
                alert("삭제 완료");
                location.reload(); // 이 페이지 통째로 새로 부르기
            } else {
                alert("삭제 실패");
            }
        });
}

function modifyPost(id, btn) {
    const cardBody = btn.closest(".card-body");
    const contentArea = cardBody.querySelector(".content-area");

    // 현재 버튼의 상태가 "수정"이면 입력칸으로 교체
    if (btn.innerText === "수정") {
        const currentTitle = contentArea.querySelector(".card-title").innerText;
        const currentText = contentArea.querySelector(".card-text").innerText;

        // 1. 입력창으로 UI 교체
        contentArea.innerHTML = `
            <input type="text" class="form-control mb-2 edit-title" value="${currentTitle}">
            <textarea class="form-control mb-2 edit-text">${currentText}</textarea>
        `;

        // 2. 버튼 디자인 및 텍스트 변경
        btn.innerText = "저장";
        btn.classList.replace("btn-info", "btn-success");
    } else {
        // 현재 버튼의 상태가 "저장"이면 서버로 fetch 요청
        const newTitle = contentArea.querySelector(".edit-title").value;
        const newText = contentArea.querySelector(".edit-text").value;

        fetch(`/api/modify/${id}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title: newTitle, message: newText }),
        })
            .then((res) => res.json())
            .then((data) => {
                if (data.result === "success") {
                    alert("수정 완료");
                    location.reload(); // 새로고침하여 데이터 갱신
                } else {
                    alert("수정 실패");
                }
            })
            .catch((err) => console.error("Error:", err));
    }
}
