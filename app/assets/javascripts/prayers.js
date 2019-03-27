
///////////////////////////////////////////
// AJAX render of bible_prayer show views
///////////////////////////////////////////

$(function(){
  addBiblePrayerNavigationEvent()
})

function addBiblePrayerNavigationEvent() {
  $('button#next_bible_prayer').click(function (e) {
    console.log("Load Next Bible Prayer")
    loadBiblePrayer(this, true)
  })

  $('button#previous_bible_prayer').click(function (e) {
    console.log("Load Previous Bible Prayer")
    loadBiblePrayer(this, false)
  })
}

function loadBiblePrayer(button, next){
  let biblePrayerId = 0;
  if (next) {
    biblePrayerId = parseInt(button.dataset.biblePrayerId) + 1
  } else {
    biblePrayerId = parseInt(button.dataset.biblePrayerId) - 1
  }
  let posting = $.get(`/bible_prayers/${biblePrayerId}.json`)
  posting.done(function (bible_prayer) {
    let id = bible_prayer["id"]
    let title = bible_prayer["title"]
    let verse = bible_prayer["verse"]
    let summary = bible_prayer["summary"]
    let scripture = bible_prayer["scripture"]
    let notFirst = bible_prayer["is_not_first"]
    let notLast = bible_prayer["is_not_last"]

    biblePrayer = new BiblePrayer(id, title, verse, summary, scripture, notFirst, notLast)
    biblePrayer.display()
    addBiblePrayerNavigationEvent()
  })
}


class BiblePrayer {

  constructor(id, title, verse, summary, scripture, notFirst, notLast) {
    this.id = id;
    this.title = title;
    this.verse = verse;
    this.summary = summary;
    this.scripture = scripture;
    this.notFirst = notFirst;
    this.notLast = notLast;
  }

  display() {
    let biblePrayer = ''
    if (this.notFirst) {
      biblePrayer += `<button id="previous_bible_prayer" data-bible-prayer-id="${this.id}" class="button is-text" style="float:left;">Previous Bible Prayer</button>`
    }
    if (this.notLast) {
      biblePrayer += `<button id="next_bible_prayer" data-bible-prayer-id="${this.id}" class="button is-text" style="float:right;">Next Bible Prayer</button>`
    }
    biblePrayer += `<br><br><h1 class="title is-2">${this.title}</h1>`
    biblePrayer += `<h4 class="subtitle is-4">${this.verse}</h4>`
    biblePrayer += `<h4 class="subtitle is-6">${this.summary}</h4>`
    biblePrayer += `<div class="column is-one-third is-offset-one-third"><hr></div>`
    biblePrayer += `<h4 class="subtitle is-5">${this.scripture}</h4>`

    $('div#bible-prayer')[0].innerHTML = biblePrayer
  }
}

/////////////////////////////////////
// AJAX post of create group_comment
/////////////////////////////////////

$('form#new_group_comment').submit(function (e) {

  createGroupComment(this);

  e.preventDefault();
})

function createGroupComment(form){
  let url = form.action
  let data = $(form).serialize();
  let posting = $.post(url, data)
  posting.done(function(comment){
    if ($('div#group_comments')[0].innerText === "No comments have been posted") {
      $('div#group_comments')[0].innerHTML = ''
    }
    $('div#group_comments').prepend(comment);
    $('#group_comment_content').val('');
  })
}

//////////////////////////////////////////////
// AJAX render of prayer_comments index view
//////////////////////////////////////////////

$('button#show_comments').click(function (e) {
  if ($('article.message').length) {
    hideComments()
  } else {
    showComments(this)
  }
})

function showComments(button) {
  let prayerId = parseInt(button.dataset.prayerId)
  let currentUser = button.dataset.currentUser
  let posting = $.get(`/prayers/${prayerId}/comments.json`)
  posting.done(function(response){
    // response is array of comments => iterate over array and create new Comment per each
    response.forEach(function(comment){
      let id = comment["id"]
      let content = comment["content"]
      let commenter = comment["commenter"]["username"]
      let time = comment["time"]
      let adminButtons = false;
      if (currentUser === commenter){
        adminButtons = true;
      }
      comment = new Comment(id, prayerId, content, commenter, time, adminButtons)
      comment.display()
    })
  })
}

function hideComments() {
  let commentCount = $('article.message').length
  $('div#comments_index')[0].innerHTML = '';
  $('button#show_comments')[0].innerHTML = `Show Comments (${commentCount})`
}

class Comment {

  constructor(id, prayerId, content, commenter, time, adminButtons) {
    this.id = id;
    this.prayerId = prayerId;
    this.content = content;
    this.commenter = commenter;
    this.time = time;
    this.adminButtons = adminButtons;
  }

  display(){
    let comment = `<article id="comment-id-${this.id}" class="message"><div class="message-header">`
    comment += `<p><strong>${this.commenter}</strong></p>`
    comment += `${this.time}`
    comment += `</div><div class="message-body">`
    comment += `<p>${this.content}</p><br>`

    if (this.adminButtons) {
      comment += `<a class="button is-small is-outlined" href="/prayers/${this.prayerId}/comments/${this.id}/edit">Edit Comment</a>`
      comment += `<a data-confirm="Delete this comment?" class="button is-small is-outlined" rel="nofollow" data-method="delete" href="/prayers/${this.prayerId}/comments/${this.id}">Delete Comment</a>`
    }
    comment += `</div></article><br>`
    $('div#comments_index').append(comment)
    $('button#show_comments')[0].innerHTML = "Hide Comments"
  }
}