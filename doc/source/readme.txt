        #T2HTML-TITLE Procmail strategies against spam
        #T2HTML-METAKEYWORDS Procmail, pm-lib, spam, UBE, Exim 4, bogofilter, Bayesian, Spamassassin
        #T2HTML-OPTION --css-code-bg
        #T2HTML-OPTION --css-code-note
        #T2HTML-OPTION Note:
        #T2HTML-OPTION --simple

1.0 Thoughts about increasing spam annoyance

        By Jari Aalto (AT cante net).

        License: This material may be distributed only subject to
        the terms and conditions set forth in GNU General Public
        License v2 or later; or, at your option, distributed under the
        terms of GNU Free Documentation License version 1.2 or later
        (GNU FDL).

    1.1 Bouncing messages do no good

            Note: the bounces referred here concern only messages that
            are sent from _accounts_ that *have* *already* *accepted*
            messages. Mail transport layer reject messages are not in
            this sense bounces, but delivery status notifications
            (#URL<http://www.ietf.org/rfc/rfc1891.txt?number=1891><DSNs>).
            The mail server is the only place where rejects may be
            handled intelligently with SPF and other methods.
            Individual account holders disencouraged to practice
            bouncing or other message replying tactics.

        In today's
        #URL<http://dmoz.org/Computers/Internet/Statistics_and_Demographics/Internet_Traffic/><Internet>,
        where message count has increased sky high, the sender's
        address no longer reveal the spammer behind it. Using a
        procmail recipe or other auto-responder program which would
        bounce the message back does nothing but harm because the bulk
        spammers use _other_ _people's_ email addresses. The programs
        are not replying to the real originator of the messages, but
        to *poor* *individuals* whose addresses had been hijacked by
        collecting them form Usenet newsgroups, web pages, mailing
        lists etc.

        #PIC pic/address-harvest.png # In addition to "fake addresses" spammers also  collect valid addresses which are then used in forgeries. A reply to Unsolicited Bulk Email message will not reach the real originator, but a innocent individual, whose email address has been abused. ###

        In the #URL<http://darkwing.uoregon.edu/~joe/spamwar/><"Winning the War on Spam" (2003)> Joe St Sauver Ph.D. addressed the amazing
        figures that spam covers around
        #URL<http://www.postini.com/stats/><70 %> of the total messages
        delivered. The big ISPs like according to #URL<http://www.senderbase.com/><Senderbase> and Sauver handle vast amount of messages: Yahoo 841, Hotmal 532 and 331 AOL million/day. Those volumes explain a number of things.

        #PIC pic/postini.com-stats.png  # Spam statistics reported by www.postini.com/sats as of 2005-05-18. According to finer statistics page link "More Spam statistics" in picture, the amount of bulk email was 97 % and during six months 102 terabytes of spam were fallen into traps. ###

        New kind of attacks (see #URL<http://www.gwsae.org/executiveupdate/2004/December/spam.htm><Stopping the "New" Spam: Directory-Harvest Attacks>)
        have also been serious threat to attempt to gain access to normal email addresses. With DHA if the spammer has a few addresses at company which shows their email format appears to follow FIRST_NAME LAST_NAME @example.com scheme, then they can try generating messages based on people's names mentioned in the company's web pages.
        The other harvesting methods were described in comp.mail.misc #URL<http://groups.google.fi/groups?&threadm=c1.01.2tjvHH%245AJ%40J.de.Boyne.Pollard.localhost><thread 2004-12-03>:

      UBE senders generally harvest mailbox names from Usenet by using the
      "XOVER" NNTP extension (RFC 2980). An article overview comprises the
      subject, author, date, message-id, references, byte count, and line
      count of an article. In particular: Because it *doesn't* comprise the
      "Reply-To:" field, mailboxes that occur only in "Reply-To:" fields
      are rarely harvested; and because it *does* comprise the
      "Message-ID:" field, UBE can often be seen sent to bizarrely named
      mailboxes that are actually the message IDs of articles. UBE senders
      rarely download entire articles and harvest them. Parsing overview
      information is easy (It's designed to be machine parseable.), whereas
      scanning article bodies is a lot harder. Mailbox names in message
      bodies are rarely harvested. Generally the actual cause of mailbox
      names being harvested from message bodies is when a UBE sender's web
      crawler follows a hyperlink to a message published by a company
      providing a web interface to Usenet. (Notice that, as of today,
      Google Groups no longer handily converts mailbox names into "mailto:"
      hyperlinks - which are also easy to harvest. However, this is not
      true of all web interfaces to Usenet.) --Jonathan de Boyne Pollard

        The bounces or auto-replies sent today from various sources are
        amplifying the traffic problem. One particular issue is the
        handling of message that carry a virus. Many sites have integrated
        virus scanners to their mail servers (MTA; Mail Transfer Agent) to
        check all incoming messages, so that their internal computers are
        not infected. But many do not know that the de facto response to
        "reject" a message containing Unsolicited Bulk Email or virus is
        very bad strategy. Some sites may enable a feature which sends
        "friendly notifications" to warn that the message contained a
        virus. The idea may have been to help make the sender aware of the
        problem and have him check his environment. It can be easily seen
        how these rejects and auto-replies from virus and spam scanners are
        spreading the problem.

        #PIC pic/mta-viruses.png # Virus messages are so special, that the normal mail server reject is COMPLETELY improper action to take. In 99.99% of the virus messages, it will not be the RCPT FROM: who is sending the virus. The address is a lie and when message is rejected, it will simply be forwarded to some other person who later finds it from his mailbox. This is also example of a "Joe-Job" (See later). ###

        How would the mail server react, when it notices questionable
        message which is flagged as spam or which is carrying a virus? It
        could:

        o   _accept_ _and_ _drop_ _the_ _message_
        o   reject, causing previous mail server to raise a DSN
        o   accept and send onward
        o   accept, strip, and send onward
        o   or don't look, so it is unwittingly accepted and send onward.

        There are strong arguments that *all* the last four are wrong, and
        are likely to _cause_ _an_ _innocent_ _person_ _to_ _be_
        _affected._ The only sensible action is the first one. There is
        really no place where messages could be sent. A quarantine or
        `dev/null' are the only reasonable valid destination. It would be
        good if every mail server would perform a checks so that end user's
        wouldn't need to worry. The mail server level checking is scalable
        and incrementally beneficial. Spam and virii do exist - in large
        numbers and every ail server that rejects them potentially causes a
        Delivery Status Notification (DSN) to go to an innocent.

        These bad bounce scripts or other auto-responders fill many
        innocent persons' mailboxes and after a while those people's
        accounts are effectively made unusable. Imagine a
        bounce-bombing to persons who are technically illiterate and
        who have no means to stop receiving "bounces". The bounces are
        perfect missiles to take off people's control of their mail
        management. Here is the one comment dated 2004-04-06 from a
        discussion of
        #URL<http://groups.google.com/groups?threadm=fadv4c.7ft.ln%40mail.binaryfoundry.ca><comp.mail.misc>
        how it feels like getting bounces:

      About 5 times per day I get bounce messages from mail servers
      rejecting e-mail that I did *not* send. Obviously somebody (and
      probably more than one entity) is regularly forging my address as their
      "From" address.

      Better yet, every six months or so I'll get spam from a really clever
      spammer who makes sure the "To" and "From" addresses match. Since I'm
      not in the habit of trying to sell anything to myself, I'm quite sure
      that a spammer has forged the "From" address of that!

      I know I'm not the only one either. Plenty of people I know have
      had the same thing happen to them. And that is precisely the
      reason why the experts tell you to never, ever bounce spam. The
      challenge from your system would be at least as much of a
      problem as the bogus bounce messages
      --John-Paul Stewart

        And in another comp.mail.mic
        #URL<http://groups.google.com/groups?threadm=41611D3A.6020109@bullet3.fsnet.oc.ku><thread 2004-10-04>
        the experiences were
        even worse:

      Last year (in 12 months), I directly received about 8,000 spam.
      So far this year, it has reached 28,000 (which I can easily
      filter) and there are still 3 months to go. I am now receiving
      bounced spam caused by the bastards now using my email domain in
      the From: field of their spam. Based on the exponential growth
      of the spam messages from last year, I can expect a similar
      exponential growth in the bounced spam and so my email addresses
      are going to become totally unusable towards the ends of next
      year cause by the MTAs bouncing the spam sent to them to me.

      This I would definitely call an abuse by the ISPs - their MTAs
      are bouncing to the easily forged From: field as opposed to
      tracing the email to its correct originating address (via
      slightly, but not very much, harder to forge fields). The only
      solution I have to this is to simply bounce the spam back to
      them under exactly the same conditions it was sent to me: the
      To: field doesn't contain a valid email address.

      The next result of this is a three-fold increase in spam at no
      further cost to the original spammer: their original spam, the
      bounce to a non-existent address, followed by a bounce back to
      the original bouncer - is this REALLY a sensible state of
      affairs?
      --Robert Newson

        It is better to be a intelligent Net citizen and _a)_ refuse
        to use any bounce or auto-reply tactics _b)_ contact the
        developers who might use or consider using code that include
        mail shooting practises and explain why it is not good a idea;
        and _c)_ boycott any such solution and point people to better
        alternatives, like Bayesian filters (see later).

        Speaking of auto-responses or bounces in procmail world, this
        means that whatever project is chosen, it should pass the
        following test. If there are any lines where HOST is undefined
        (or set) near setting the EXITCODE, that solution should be
        alarming, whatever it was. Contact the author who may not be
        aware of the unnecessary and harmful bounces that the scripts
        may produce.

            $ cd root/of/project/of/procmail/scripts
            $ find . -type f | xargs egrep -n "HOST|EXITCODE"

        Further reading

        o   *Rejecting* *or* *Bouncing* *Back* *a* *Message* by
            Nancy McCough. From there you can find more articles and
            strong arguments why bouncing strategies should be avoided.
            http://ii.best.vwh.net/internet/robots/procmail/qs/#reject
        o   *Bounce* *Messages.* "... The concept of sending fake bounces
            can be very seductive to those who don't understand the
            consequences."
            http://spamlinks.net/filter-bounce.htm
        o   *A* *Plan* *for* *Spam* by paul Graham who was behind the
            the idea of statistical Bayesian filters.
            http://www.paulgraham.com/spam.html

        Related software

        o   "...Address harvesting web crawlers are about as intelligent
            as the spammers who use and/or develop them, which is to
            say not very. The majority of these programs can be easily
            fooled into accepting lots and lots of completely fake and
            useless e-mail addresses, so long as the bogus addresses
            in question appear to reside on ordinary nondescript web
            pages. That is where Wpoison comes in."
            <http://www.monkeys.com/wpoison/>

    1.2 Rule based systems are not the solution

        A lot has been said about procmail and its wonderful mail
        handling capabilities. Most of them are true and it is the
        Swiss army knife to messages. But it is also true that
        Procmail's syntax is scaring and all it can do, is to match
        according to *regular* *expressions*. It is a false assumption
        that mere procmail recipes can filter all incoming Unsolicited
        Bulk Email -- they cannot. Whatever procmail based filters are
        announced to solve the Unsolicited Bulk Email (UBE) problem,
        they all sell thin air. These include procmail solutions like:

        o   SPASTIC     http://www.sf.net/projects/spastic
        o   Spambouncer http://www.spambouncer.org
        o   JunkFilter  http://www.sf.net/projects/junkfilter
        o   Procmail Module Library's UBE handling modules
            (pm-jaube.rc, pm-jaube-keyword.rc)

        Be skeptic and and don't believe possibly claimed high
        accuracy rates. Every person's UBE signature -- type of UBE
        received -- is different, so no generic filter program can
        have that wide of spectrum of rules to cut them all. One
        person's spam may be other person's normal mail.

        There is no drama here. The statement "thin air" was a bit
        exaggerated but one era of spam fighting -- rule based -- has
        finished and another -- statistical one -- has begun. Procmail
        can no longer be seriously considered as being the king of UBE
        filtering. No rule based solution cannot achieve the high
        enough confidence level to sort out what messages can be
        considered good and what bad. There are too many bulk mail
        distributors, message contents change all the time and
        Internet's bandwidth increases will open highway to many new
        "Lease an account, shoot & run" undertakings . It's a never
        ending arms race to keep rule based filter up to mutable UBE.
        The manual work to keep such filters even remotely in a good
        shape might be possible only for a few. To spend several hours
        analyzing mail logs in order to fine tune "slipping" rules is
        task that is unrealistic. You've probably heard what happened
        to wonderful UBE detection program Spamassassin? It added a
        statistical Bayesian analysis option after concluding that
        even it had to raise hands up; too many false positives by
        using solely rule based detection. The Freshmeat article later
        referred in this document demonstrates well the deficiency in
        Spamassassin when no Bayesian feature is enabled.

        After this introduction, it should be clear why hand written
        rules are not the solution to stop UBE. While the true
        Unsolicited Bulk Email Filtering race has been lost with
        procmail only solutions, procmail continues to have a firm
        place in the mail system. For serious unwanted mail filtering
        the plan is _to_ _integrate_ *other* *programs* to procmail.
        The glue doesn't necessarily have to be procmail, it might as
        well be `sieve' or any other mail server supported language.
        Injecting messages to Bayesian statistical tools for analysis
        give the best defense there is now.

        There are couple of approaches how the procmail setup can be
        arranged to integrate external analysis programs. In
        some cases and in some environments it *may* be feasible to
        still use "pure procmail only" system. But seriously, the
        heavyweight suggestion presented in this document gives the
        best fruits and a maintenance free system. Examine which one
        is in within your reach or which one you would like to prefer.

        Other related procmail projects:

        o   Virus snagger
            http://vsnag.spamless.us/
        o   E-mail sanitizer. Tool for preventing attacks on your
            computer's security via email messages
            http://www.impsec.org/email-tools/procmail-security.html

    1.3 Challenge-Response systems make matters worse

       1.3.1 Challenge-Response is not a doorbell but a gun shooting decoys

        The word on the street has whispered that challenge-response
        strategy, authorized-senders-only policy or a Email-password
        system (where password is mailed back to the sender), would
        completely eliminate spam. Many consider this to be the
        ultimate strategy to make the sender take actions to verify
        that he exists. Usually the challenge consists in solving a
        captcha (cf. #URL<http://en.wikipedia.org/wiki/Captcha><Wikipedia>).
        #URL<http://www.captcha.net><Captchas> are tasks that
        are trivial for humans but highly complex and expensive to
        solve for computers. The idea is that for each message a
        challenge is returned. It may be a simple task such as
        returning an answer to well known fact like "what circulates
        around the earth?" or filling out a form or returning message
        which was modified to includes a unique hash-key typically in
        `Subject:' line. Presumably, spammers won't bother. Some
        challenge-response system may even warn that it is going to
        automatically blacklist the email address if the message is
        not responded to.

        The reason why C-R systems is so deceptive to end users is
        that they are faced with a simple problem: how to reduce
        unwanted messages? And a C-R promises to cure exactly that by
        comparing itself to house and a doorbell. The famous analogy
        is that "You don't come in without knocking first in real
        life, so why should you be allowed to do that with email?".
        The email doorbell is so easily installed (a sent C-R bounce),
        that implementing it e.g. with procmail takes no time at all.
        Fast and cheap solution to the end user -- just what they asked
        for.

        #PIC pic/cr-system-authentication.png # The concept "you must authenticate yourself before mail is accepted" is simple. Each side use white lists where email addresses are stored so that no further challenges are needed in future correspondents. The system is intriguing and the problems are not obvious at first. The basic assumption in the C-R system is that the sender can be identified. The identification id used is a EMAIL address which is stored in while lists. The problem at points (A) and (B) is that the EMAIL address is not reliable authentication id because it can be forged without efforts. Messages coming in the name of "bar@from.com" in the future (after address is in white lists) can come from a abuser who uses this innocent person's email address. It's quite easy and nothing can prevent that. It is a known fact that white listing people by their email address is not effective because the incoming email address cannot prove the sender's identity. The problems at point (B) are discussed further in picture where sending challenge causes a "Joe-Job". ###

        Sounds like a good strategy? To a single end user a C-R system
        would solve all problems, but deployed "en masse" would cause
        serious and long reaching consequences.

        First of all the analogy about the house and doorbell is
        wrong. Internet is not built on permanent houses but temporary
        and changing email addresses. New Internet service providers
        pop up every day and people can change they accounts and email
        addresses like they change their shirts. The "house" in
        Internet is a moving target and we all know what happens if a
        moving target is tried to shoot at. It won't succeed at first
        shot and not at second either. In the end the target may not
        be shot down at all even after many rounds. The bird was just
        too high or the aim angle was wrong etc. No problem, better
        luck next time? Right? Wrong. Those ammunitions, C-R
        challenges, eventually reach a target. If they do not hit the
        bird, they hit trees, ground and innocent bystanders. The more
        shots, the more damage they do.

        The irony here is that the shooter (C-R system deployer; end
        user) never sees the damage the C-R system is causing to all
        over the Internet. The other irony here is that the bird
        (spammer) was never there at all. He used a decoy which
        tricked load of ammunitions to get shot - shot somewhere and
        the decoy wouldn't care less. But how happy are the bystanders
        who were shot? It can be imagined that after a joe-job
        resulted from using C-R system, there is a bounty offered on
        the deployer.

        #PIC pic/cr-system-joe-job.png # Challenge-Response system and its fundamental flaw. It is not possible to know the sender's address, so any challenges being sent are possibly returned to innocent third parties, whose email addresses have been hijacked. Spammers may collect addresses and pretent to be someone else by forging the identity at SMTP RCPT MAIL FROM time. All C-R system where the abusers inject the false addresses shoot back in the dark and the innocent victims are under attack of so called "Joe-Job". ###

       1.3.2 Modern C-R systems are no better

        It is often heard that the C-R system is used only _after_ all
        other checks have been made, thus reducing the number of sent
        challenges. A word 'modern C-R system' is often described
        consisting of:

        .   Pass-List (known contacts are taken off the top)
        .   Block-List (broadly tuned-conventional-spam-filter that
            dumps all the obvious spam + any address or
            domain you choose to block)
        .   Challenge-Response (for the tiny percentage that remain)

        This is good practice and better than treating every mail
        hostile by default. However, the basic assumption still stays:
        C-R system _believes_ that it can use valid address. This is
        not correct assumption. The *addresses* _cannot_ _be_
        _reliable_ _used_ for white/pass listing, black/block listing
        or destinations where to send a challenges. Relying on
        addresses is source of many problems, due to email forgeries.
        This also raises question what is the use of a
        challenge-response system if it cannot be used unless most of
        the email messages has been filtered away? What is left for
        the challenge-response system to filter out? The flaw in even
        'modern' C-R systems is:

      If one knows that the message is NOT spam per one's filter, why does
      it need to be challenged in the first place?

        The 'modern' systems with strong pre-filtering and with more
        published SPF record may reduce chances of misdirected challenge
        _but_ both reduce gains offered by C-R systems. If the intention is
        to keep the spammers out of the mailbox, the C-R system does not
        work towards that goal, but rather keeping people out of
        communicating each other by locking everyone behind their accounts.
        C-R can be used to implement some kind of priority treatment in
        situations when auto-replies are sent anyway (e.g. accepting
        reports to abuse@*) with challenges "included" in auto-reply (as
        URL link or VERP sender).

        What about Microsoft proposed domain key or other pre-measures?
        This was discussed in comp.mail.misc
#URL<http://groups.google.com/groups?threadm=Pine.LNX.4.61.0502041005310.216%40kd6lvw.ampr.org><thread 'Welcome to Comp Mail Misc' 2005-01-04>

      Using domain keys one already knows that the sender really was the
      sender, so can be the challenge would serve no purpose. Either the
      message is known to be spam and discarded (or other action) or it is
      not spam (as determined by one's filter) and should be delivered. In
      the case it's "missed spam", it should still be delivered in order to
      inform the filter maintainer that the filter needs adjustment. That
      will not do anything to eliminate "authenticated spam". Nor will that
      prevent spam from hijacked accounts (mailboxes). All it will do is
      reject (at best) messages which have the sender faked. Not all
      spammers do that. --D. Stussy

      [ in same thread but earlier 2005-01-24] The problem is that ANY C/R
      message is spam amplification. ONE is too many. The fact that some
      spam slips through means ADJUST THE FILTER. It is not a license to
      spam others via C-R. --D. Stussy

       1.3.3 Questioning Challenge-Response system implementations

        If we think it a little further we find that there are several
        deficiencies in C-R:

        o   *First* message from unknown sender must be initially
            confirmed. To contact 100 people all over the world another 100
            challenges are returned. There is no guarantees that once a
            message has been confirmed no further confirmations will never
            be needed. What if the confirmation database gets lost or
            deleted? Disk breakdown?
        o   A C-R system cannot tell whether an address is the real
            sender or a forged address. Sending challenges to forged
            or unknown address is same as sending message to *innocent*
            *third* *party*. This is called
            #URL<http://www.everything2.com/index.pl?node=Joe%20Job><Joe Job>.
            See article #URL<http://www.joewein.de/sw/spam-joejob-info.htm><"Clueless virus filters spam innocent third parties"> for more information.
            The
            #URL<http://www.spamfaq.net/terminology.shtml#joe_job><forged>
            "From"
            addresses are not a minority. Spammers don't put their address into either
            the `From' or other fields on their e-mail. They never get
            C-Rs at all. If your email address is hijacked,
            refer to
            #URL<http://groups.google.com/groups?threadm=3C703AAC.3923EDA5%40tls.msk.ru><this article>.
        o   Spammers can run their own mail servers and have the
            capability to reject anything sent to them. That's why
            sending a C-R to a claimed spammer address is useless. C-R
            messages in reality harass normal people, who _do_ _not_
            send spam in the first place. The victims of C-R are
            the previously mentioned third parties, whose addresses
            spammers use.
        o   If challenge is lost, the original sender may get blacklisted
            (depends on the receiving end) and he may not be able to
            cannot contact the other party never again.
        o   Joe sends message to A who is running C-R, but forwards
            the message to company helpdesk at B which also uses C-R.
            Later B responds to Joe, but Joe has had no prior
            communication with B. It is unclear if Joe must again go
            through C-R with B or if B's C-R system is intelligent
            enough to white list Joe automatically. if A and B are in
            discrete locations, they may be running different C-R
            systems.
        o   If both parties use C-R, the _receiver_ returns
            a challenge, but in order to accept it, _sender's_ C-R
            software responds with challenge ... and the loop
            is ready. Who is going to verify what? Who is going to
            return the first challenge in sign of trust?
        o   When A uses N email addresses, to send message to B, how
            many challenges A has to to respond to? A simple math: A
            (uses 10 different email addresses) sends to B (10 persons
            who all use C-R), then in worst case A must return 10 * 10
            challenges to authorize all his 10 different addresses to be
            accepted by B. So, for 10 messages, 100 times of work
            does not sound reasonable.
        o   How does A know that B's challenge is genuine? I.e. that
            by responding to it he is not responding to a spammer who
            is gathering email addresses?
        o   Once the spammer get's through the challenge, he has
            a open highway to send as much Unsolicited Bulk Email
            as he can before it is noticed. Any spammer can use robots
            to  auto-reply to C-R's, allowing them to instantly access
            the addresses.
        o   What about mailing list messages? Or other automatic
            messages? It would require artificial
            intelligence to check which messages look like "human"
            and which don't and when to send challenge and when not.
            No C-R system to date include sufficient AI to send
            challenges intelligently.
        o   What about different mail server's reject messages that are
            not consistent enough (user's mailbox is full etc.) or
            wide variety of other bounce messages?
        o   Worse even, the automatic replies of C-R
            spam filters can be easily abused. In a concerted action
            (it need not even be an attack), spam can be sent "from" a
            certain address to thousands of C-R enabled
            email addresses. The victim address will be bombarded by
            thousands of challenging messages immediately and have at
            least their mailbox clogged.

        Scenarios to consider:

            a)

            [1]  <A> uses a C-R system
            [2]  <B> uses a C-R system
            [3]  <A> sends an email to <B>
            [4]  By sending that email, <A> whitelists <B>
            [5]  <B>'s C-R intercepts <A>'s email
            [6]  <B>'s C-R sends a challenge to <A>
            [7]  <A>'s C-R passes <B>'s challenge onto <A>
            [8]  <A> sends the password response to <B>
            [9]  <B> accepts <A>'s password
            [10] <B> reads <A>'s original message
            [11] <B> responds to <A> from work, with his work email address
            [12] <A>'s C-R intercepts <B>'s email
            [13] <A>'s C-R does not recognize <B>'s work address
            [14] <A>'s C-R sends a challenge to <B> . . .

            b)

            If A writes to B from work, but sets Reply-to: to A's
            home address, which address gets the C-R email? The
            (incorrect) work address or the (correct) home address?
            Which email address is the C-R expecting a reply from?

        The workstations are not the only media that is used to handle
        mail. A very valid point regarding the used technology was raised
        in comp.mail.mic #URL<http://groups.google.com/groups?threadm=Pine.GSO.3.95.iB1.0.1041004114616.29081D-100000@halifax.chebucto.ns.ca><thread 2004-10-04>

      Some people have email-only accounts or may be reading their
      email on cell-phones that provide only email support. They can't
      respond to C-R "click here". Some people are behind company
      firewalls that allow email to pass through but block http access.
      They can't "click here". Some people may be using company
      machines that, by company policy, have email software installed
      and no browser at all. They can't "click here". That doesn't mean
      that they are "dumb". I even hear about systems where email can
      be read to you over the telephone with text-to-speech converters.
      People using such a system can't "click here". Such people may be
      physically blind but are probably not dumb.
      -- Norman L. DeForest

        A C-R system may look like a solution, but it only make things
        more difficult, more messages are send back and forth and
        people begin to be seriously tired of confirmations.
        Challenges may get lost (mailbox full) and mail is sometimes
        trashed (filtering in the receiving end). A C-R system is a
        perfect tool to make Internet mail based communication to die
        completely.

       1.3.4 Summary - What are the effects of Challenge-Response systems

        The bottom line is that C-R increases enormously mail traffic by
        tripling the bandwidth (or more), because for the message, there's:

        o   The message itself
        o   The challenge
        o   The response (if ever issued)

        It also takes people's time off communicating due to double work.
        C-R can be considered in essence another kind of Unsolicited Bulk
        Email which sender never asked for. Not only is the challenge
        annoying and can be perceived as rude, a lot of people will also
        not be sure what to do. The impression they get is that the
        recipient's email system is broken in some way and that they can't
        send mail. It can also be questioned if it is ethically correct
        that by design C-R offloads the filtering of spam from the user to
        previously-uninvolved third parties.

        The problems presented here concerning Challenge-Response systems
        are not in no unique to it. The original SMTP design couldn't see
        the situation faced now, where address forging is the norm. Any
        program, any auto-responder, like the ages old Unix vacation program,
        can be tricked into being a device to be used in denial of service
        attacks (Joe-Jobs) against third parties. This is similar to
        anti virus systems which send bogus notifications to forgery
        victims. It is arguable that until there is plans to revise the
        SMTP protocol or to add some kind of strong authentication
        mechanisms between the sender and the mail server, these problems
        persists for all auto-responder tools -- including C-R systems --
        and therefore these "open spam relays" should not be used.

        Here is comment from personal web log titled
        #URL<http://jeremy.zawodny.com/blog/archives/001931.html><TMDA Users Can Blow Me>
        that expresses how it feels like getting in touch with a C-R
        system:

      This is freaking stupid.

      First of all, I never respond to anti-spam e-mail "challenges"
      whether they are from TMDA, SpamArrest, or anyone else. Ever. On
      my personal e-mail account, I have a procmail rule that ensures
      I almost never see them (unless they're heavily customized and
      my rule misses, of course).

      A reader (of the book) just e-mailed me (at my work address for
      some reason) to ask a question. I spent the time to answer his
      question only to be rewarded with a message (via his TMDA
      install) that he's not going to read my message unless I jump
      through another fucking hoop. Screw that! You know why?

      HE CONTACTED ME FIRST!

      If these systems are so brain-dead as to not bother adding my
      address to the whitelist when the user sends me e-mail, I have
      serious trouble understanding why anyone is using them. Is it
      just me? Is this too hard to figure out? Anyway, there's another
      5 minutes I'll never get back. It's too bad there's no mail
      header to warn me that "this message is from a TMDA user",
      because then I'd be able to procmail 'em right to /dev/null
      where they belong. Ugh.

      This bullshit is not going to "solve" the spam problem, people.
      If that's your solution, please let me opt out. Forever.
      --Jeremy Zawodny's blog

        And the situation can go really serious after email hijacks:

      .> As former victim of such a harvested email address being used
      .> as sender for spam, I can only strongly affirm that the damage
      .> is very real.  I received about 2000-3000 "replies" on the first days
      .> going from "user unknown" (usually from MS Exchange mailers) to real
      .> insults directed to me personally (which must have been taken a
      .> considerable amount of time of the writers too).
      .> Even weeks after the event, I still received back scatter emails.

      .. and I am victim since around 2 years. At least one time per
      week I get such DOS on my <linux4michelle> and then I get
      between 500 and 34.000 Messages a day. Currently I get around
      14.000 per day and 95% of them on <linux4michelle>. Because I am
      Debian-Consultant and working seriously, I do not change my
      E-Mail each week, but SPAM is the price.
      --Michelle Konzack in Procmail mailing list 2005-07-27
      <http://article.gmane.org/gmane.mail.procmail/14662>

        In the US some big Internet Service Providers
        (See Washington Post article 2003-04-07 #URL<http://www.washingtonpost.com/ac2/wp-dyn?pagename=article&contentId=A22390-2003May6&notFound=true><"EarthLink to Offer Anti-Spam E-Mail System">) started
        to offer C-R system to end users. But his has proven to be only a short term solution. Later 2004 large ISPs announced joint effort (See #URL<http://www.viruslist.com/en/news?id=154965305><"Digital signature technology to eliminate spam?">)
        to move to digital signature based message authentication technology as outlined by Yahoo in their #URL<http://antispam.yahoo.com/domainkeys><DomainKeys>.
        Others have #URL<http://jeremy.zawodny.com/blog/archives/001169.html><commented>
        the issue and have reservations towards DomainKey solution and believe #URL<http://spf.pobox.com><SPF> to implement the same concept much better. Here is one experience from using one of the ISPs services posted in comp.mail.misc
        #URL<http://groups.google.com/groups?threadm=cjmivk$nft$1@panix2.panix.com><thread 2004-10-02>:

      When my Earthlink email address finally was closed some six months
      ago, C/R was strictly opt-in, under the control of the user. If
      that's still the case, anyone who opted into it should be capable of
      opting out of it. There's no need to ask Earthlink staff to do it. I
      tried their C/R for a while, but as I got nothing at that address
      except dictionary-attack spam that slid through the prior layer of
      spam detection, all the challenges were either vanishing or harassing
      innocent third parties, so I shut it off. --David W. Tamkin

        And what really happens if C-R systems are more widely taken
        was discussed in
        #URL<http://www.politechbot.com/p-04746.html><Politics & technology>
        mailing list.

      No, it's worse than that. The collateral damage from widely used
      C/R systems, even with implementations that avoid the stupid
      bugs, will destroy usable e-mail.

      Challenge systems have effects a lot like spam. In both cases,
      if only a few people use them they're annoying because they
      unfairly offload the perpetrator's costs on other people, but in
      small quantities it's not a big hassle to deal with. As the
      amount of each goes up, the hassle factor rapidly escalates and
      it becomes harder and harder for everyone else to use e-mail at
      all.

      (...)

      But the real damage from challenge systems will come when
      spammers start attacking them. Challenge systems all have user
      white lists so that each correspondent only gets one challenge,
      then mail goes through directly. So spammers will start trying
      to send spam with forged sender addresses that are on the
      recipients' white lists. That's not so hard, sign up for a
      mailing list, scrape addresses from the list traffic, then send
      NxN copies of spam, to each list address from each list address.
      Similarly with addresses scraped in groups from web pages,
      Usenet groups, and anywhere else scrapage happens.

      You won't be able to trust that mail from your friends is
      actually from your friends, since an increasing fraction will be
      spam leaking through your challenge system. What will people do?
      Given the basic principle of challenge systems, which is that
      it's someone else's job to solve your spam problem, people will
      dump their white lists and start challenging every message. At
      this point, it's possible to automate much of the work, most
      challenge systems are scriptable, so that for example I have a
      few lines in my mail sorting filters that catch the per-message
      challenges from submissions to Dan Bernstein's mailing lists and
      automatically send confirmations. But of course, if I can send
      responses from scripts, spammers can and will too, so challenge
      systems will increasingly include "prove you're human" features
      like showing you a picture and asking you how many kittens are
      in it. Now we'll have challenge systems duelling to the death,
      since everyone will be insisting that everyone else confirm
      first. There should be ways to mitigate the damage, by using a
      mechanism other than e-mail for the challenge traffic, but I
      don't see anyone deploying them or even thinking about what a
      world where everyone challenges e-mail will be like.

      So anyway, you heard it here first, challenge systems will
      destroy e-mail as we know it. Yeah, this sounds apocalyptic, but
      the pieces are all falling into place, and spam problems
      consistently get worse faster than anyone expects. How many
      people would have predicted even a year ago that by now there'd
      be more spam than real mail on the net? Yet that's the reality
      already, and the challenge juggernaut is gearing up fast.
      -- John Levine, primary perpetrator of book "The Internet for Dummies"

        As it is shown that any address based authentication,
        blacklist or white list, does not work, many concur with it
        from personal experience. Here typical conclusion from
        #URL<http://www.spack.org/wiki/SpamBlacklistsConsideredHarmful><Adam Shand>. You should read his story by following the link.

      Just personal experience/preferences as a long time email admin.
      Blacklists are evil and I *LOATH* them, please don't ever use
      them or encourage anyone else to use them. Unless you are AOL
      (who recieves something like a terabyte of spam a day)
      blacklists cause more problems and cost more money (in support
      and trouble shooting) then spam.

      In that vein things like TMDA can be useful personal tools but i
      don't like them as general policies. In other words, use them to
      sort things into folders but don't bounce messages based on it.
      I also consider them rude, if I get a message from someone I
      tried to email with a message that says "XXX uses TMDA and you
      have to respond within X hours with X code blah", I just delete
      the message and don't bother emailing them. Why should the onus
      of communication be on the sender?

      Personally I *only* use statistical systems and I've been very
      happy. My combination of razor and mozilla's bayesian filters
      catches about 99% of my spam. Razor alone cathes about 40-60% of
      my spam which was enough to make my spam bearable ... mozilla
      has made spam mostly disappear.

      Razor occasionally catches a mailing list message as spam (it's
      happened maybe 3 or 4 times in the last 8 months) but i can live
      with that. Mozilla has only ever tag's things as spam that I
      mistakenly tag as spam, and usually that's cron messages

      (...)

      Everytime we have an employee complain about mail prolems we
      have to go through the dance of finding out if we've been
      blocked somewhere and getting ourselves unlisted. These days,
      one of the troubleshooting steps you have to go through when you
      have mail problems is trying to figure out if anyone is blocking
      you cause they think your a spammer. Way to create centralized
      points of brokeness for a decetralized service Batman!

      From a users point of view I don't like blacklists because false
      positives are inevitable, that the false positives are
      indescriminate. For example, with razor I do get occasional
      false positives but it'll never be a message sent directly to
      me, because no one has ever seen that message before. You only
      get false positives on messages sent to lists.

      Blacklists are actually more likely to block users emails then
      list email because popular lists are generally on up and up
      servers while lots of people have legitimate, but dodgy, mail
      servers.

      (...)

      .Date: Sat, 17 May 2003 16:29:29 -0700
      .To: politech@politechbot.com
      .From: Bob K -<bk@msgbase.com>
      .Subject: A "Nice Blacklist?" No such thing.

      Our ISP has been plagued by SPAM. I don't know of any ISP that
      hasn't been. But we recently shut off our use of Realtime
      Blackhole systems in favor of in-house SPAM-control. Instead of
      an effectiveness of 60% or so, we are now trapping more than 90%
      of unwanted mails, and in a way that our end users have total
      control.

      We shut off the RBLs because we incurred a huge costs as a
      result of our support for them. When the RBLs began to support
      the blocking of entire Autonomous Systems instead of targeting
      SPAMmers directly, they lost my support. I had a carrier whose
      AS numbers were put into the RBL. Like a good anti-SPAMmer I
      rejected the carrier and moved to another. My ISP is fairly
      large, and including customer support costs the carrier change
      cost my company around $35,000. (...)

      Some of the RBL operators have become so obsessed with their
      tools that they have started to create more harm to Internet
      users than the SPAMmers they want to protect those users from. A
      SPAMmer clots mailboxes. An agenda operated RBL takes the
      mailbox away. Plus, I have run out of choices for carriers. My
      area only has a few that support it, and all of them are AS-wide
      being blocked. So I tend now to view RBLs with disdain and
      disrespect. (...)

      All of the anti-SPAM efforts have created a lost perspective I
      think. That is, people should control their own mailbox. A
      system that makes arbitrary decisions about what content should
      and shouldn't be permitted is a loss of freedom of choice. So,
      there is no such thing as a nice RBL. They are more harmful than
      helpful, they are less efficient than internal methods, and they
      take freedom of choice away from ISPs and more importantly,
      their customers. As long as legitimate RBLs maintain their
      support for those RBLS that have gone rogue, or are completely
      inept, they are more criminal or problematic than SPAM. (...)

      -- Adam Shand's wiki page SpamBlacklistsConsideredHarmful

        The consequences of C-R system are not the what the designers may
        have originally intended. How the C-R notification is treated by the end users was described in comp.mail.misc #URL<http://groups.google.com/groups?threadm=Pine.LNX.4.61.0501310049270.110%40kd6lvw.ampr.org><thread 2005-05-31 "Re: Anti-C/R Nut grey dmiyu.org">

      People who are harassed by C-R systems will DISCARD them or feed them
      to their own SPAM filters as spam. Thus, in the long run, these
      abusive challenges will NEVER BE SEEN and will cause legitimate mail
      to be erroneously discarded. This breaks the basic premise of
      anti-spam systems: To maximize spam elimination while minimizing the
      impact on legitimate e-mail. C-R systems MAXIMIZE the impact on
      legitimate e-mail, by causing it to be discarded as if it were spam
      since a response to the challenge will never be made. --D. Stussy

        C-R will probably kill legitimate mail and in the worst case with
        no white listed mailboxes and no-one ever responds to a challege =>
        100% of the legitimate mail will also be auto-killed by the system.
        The goal of any anti-spam system is to maximize the elimination of
        spam while simultaneously minimizing collateral damage to
        legitimate mail (i.e. false positives). An improperly designed C-R
        system maximizes both. A properly designed C-R system doesn't
        minimize collateral damage and could devolve into maximizing it
        depending on response (or lack thereof) by the challenged. A well
        known spam reporting site Spamcop has takeng the
        #URL<http://www.spamcop.net/fom-serve/cache/329.html><stance> that
        false C-R messages #URL<http://www.spamcop.net/fom-serve/cache/14.html><are regarded as UBE>:

      Heading "Messages which may be reported:" However, these messages
      have become a big enough problem that we now allow them to be
      reported as the spam that they technically are (...) Misdirected
      challenges from challenge/response spam filtering systems

        In a nutshell in comp.mail.misc
        #URL<http://groups.google.com/groups?threadm=c4v0od%242va%241%40panix2.panix.com><thread 2004-04-06 "Challenges from challenge-response systems qualify as unsolicited">
        was described how futile a C-R system is and how it
        falsely cradles oneself into belief of imagined security. And
        unlike a broken arm, which is only problem of an individual, the
        C-R makes the problem worse for everybody.

      C-R is like taking opiates for a broken arm. It does not cure
      the problem, it only makes it feel better for a little while, and in
      the long run it will result in even more serious problems.
      --Scott Dorsey

        Is there anything that would accomplish the same as C-R? Yes
        there is. A *GPG/PGP* *signed* *message* would prove
        sender's _identity_ much better than any C-R system which
        cannot say anything about the validity of the email address.
        Taking
        #URL<http://www.desktoplinux.com/articles/AT3341468184.html><cryptographic tools> into mail messaging would be much better road. Another
        new policy using #URL<http://projects.puremagic.com/greylisting/><greylisting> has proven to
        be very effective mail server level counter measure. Greylisting is
        non-intrusive unlike C-R and implements the same concepts
        without C-R's flaws.

       1.3.5 Further reading - Mail, C-R systems, Spam

        o   IETF experimental memo by Paul Vixie: "...Simply put, there is
            no cause for ANY confidence in the proposition 'this e-mail
            came from where it says it came from.'"
            <http://ops.ietf.org/lists/namedroppers/namedroppers.2002/msg00658.html>
            See also
            #URL<http://ops.ietf.org/lists/namedroppers/namedroppers.2002/threads.html#00662><discussion>
            about proposed MAIL-FROM DNS resource record.
        o   *Challenge-Response* *Anti-Spam* *Systems* *Considered*
            *Harmful* by Karsten M. Self
            http://kmself.home.netcom.com/Rants/challenge-response.html
        o   *Countering* *Spam* *with* *Ham-Authenticated* *Email* *and*
            *the* *Guarded* *Email* *Protocol* by David A. Wheeler. A paper
            contains good summary and overview of the present situation and
            methods in spam fighting.
            http://www.dwheeler.com/guarded-email/guarded-email.html
        o   *Challenge-Response* *Anti-Spam* *Systems* *Considered*
            *Harmful* by Karsten M. Self.
            http://kmself.home.netcom.com/Rants/challenge-response.html
        o   *A* *Challenging* *Response* *to* *Challenge-Response*
            by Anick Jesdanun 2003-06-08
            http://www.freedom-to-tinker.com/archives/000389.html
        o   *Why* *Challenge-Response* *is* *a* *Bad* *Idea*
            http://tardigrade.net/challengeresponse.html
        o   *Challenge-response* *systems* *are* *as* *harmful* *as*
            *spam*. "..."
            http://www.politechbot.com/p-04746.html
        o   *Challenge-response* *anti-spam* *technology* *faces*
            *challenges* By Anick Jesdanun. "... Nicholas Graham says
            AOL won't adopt challenge-response because sending two
            billion challenges a day would tax the system and create
            unacceptable delays for subscribers ... difficulties
            because it doesn't work well with Yahoo Groups and other
            services where multiple list members post ... Amazon.com
            and other e-commerce sites also create problems: because
            they are automated, they won't respond to challenges."
            http://www.canoe.ca/CNEWS/TechNews/2003/06/08/106782-ap.html
        o   The case of *Alan* *Connor* who
            advocated C-R in debian-user mailing list and comp.mail.misc
            <http://angel.1jh.com./nanae/kooks/alanconnor.shtml> E.g.
            follow thread "Re: Challenge-response mail filters
            considered harmful" for a while at
            <http://lists.debian.org/debian-user/2003/08/thrd2.html#00647>
            His procmail based program was 2004-09-21 available at
            <http://home.earthlink.net/~alanconnor/elrav1/>
        o   *SpamArrest* *is* *Spamming*
            <http://static.samspade.org/spamarrest.html> and
            <http://www.antispamleads.com/whose_spamming.html>
        o   *SpamArrest* *Is* *A* *Spammer!* "... sending to
            abuse@spamarrest.com results in a sender verification
            request email, asking you to go through the Spam Arrest
            verification process, which will put you on the Spam
            Arrest Spam Mailing List to receive future spams!"
            <http://www.toyz.org/cgi-bin/wiki.cgi?SpamArrestIsASpammer>
        o   ...and finally Jonathan de Boyne Pollard sees that nothing
            works. There is fundamental flaw in whole Internet which
            make email abuse possible. You may want to study his opinion at
            http://homepages.tesco.net./~J.deBoynePollard/FGA/smtp-anti-ubm-dont-work.html

       1.3.6 Further reading - Some known C-R systems

        Challenge-response systems do not return spam to the sender, but
        rather assists the spammer in victimizing additional recipients.
        There is _no_ method to reliably return messages to their real
        senders. Forged sender address cannot be detected from message.
        Some known challenge-response systems include:

        o   Open Source *TMDA*. Tagged Message Delivery Agent based on
            #URL<http://tmda.net/challengeresponse.html><challenge-response>
            for al unknown senders
            <http://tmda.net/>.
        o   *qconfirm*. Qmail based add-on program, that sends
            confirmation request message to the envelope sender asking for a
            reply to confirm delivery. Similar to TMDA.
            http://smarden.org/qconfirm/
        o   Active Spam Killer (ASK) http://freshmeat.net/projects/ask/
            and http://www.paganini.net/ask/
            by Marco Paganini
        o   Commercial http://www.spamarrest.com/
        o   Timo Salmi's procmail based email password system
            http://www.uwasa.fi/~ts/info/spamfoil.html#comments
        o   Alan Clifford's procmail based MARP - Mundungus Autoresponder
            Requests a Password.
            http://www.clifford.ac/software.html
        o   Perl based challenge/response system with dns-validation
            http://www.thinknerd.org/~ssc/wiki/doku.php?id=spamresponder

    1.4 Spam appearing in your yard - a story

        The following nice analogy appeared in comp.mail.mic
        #URL<http://groups.google.com/groups?threadm=41632BA4.668F0DD9@ucsc.edu><thread 2003-10-05>.
        It describes well how various techniques
        work in the spam game:

      DOGS POPPING IN YOUR YARD

      For example, in this analogy, I would compare
      #URL<http://www.spamassassin.org><spam assassin> type filters
      to a helper that runs around the yard putting little flags on the piles
      of poop, so that you know where they are. Then you can choose to walk
      around them (in your fancy shoes, or your boots, or whatever). And
      sometimes your helper misses a pile of poop, or sometimes he flags your
      morning newspaper. But, the point is, spam assassin doesn't keep dogs
      from pooping in your yard.

      If, instead of something like spam assassin, you mean something like
      simple procmail rules that sort spam out of your way, then that's more
      like a little helper who runs around your yard scooping up things you
      told it are spam (either things your other helper flagged, or using
      other criteria), and throwing them away for you. Periodically, you open
      the poop trash can and be sure your morning newspaper didn't get thrown
      in there by accident. (thankfully, cleaning out the spam trashcan is
      more sanitary than fishing your newspaper out of the poop trashcan).
      Procmail, and other "sorting filters", doesn't keep dogs from pooping in
      your yard at all. It just tries to clean up the poop it finds.

      I agree that filters like #URL<http://www.dnsbl.org><DNSBL>'s
      (because they ARE a sort of filter ...
      well, not the DNSBL, but the mechanism by which you are integrating the
      DNSBL into your MTA) are like having a gated fence. The filter is in
      deciding which dogs get let through the gate, and which don't. The
      helper (the DNSBL) that acts as your doorman/gate-sentry may or may not
      be very accurate about which dogs he lets through. He might be good at
      only letting in the dog that fetched your morning newspaper, or he might
      be letting in dogs that just want to poop in your yard. Hopefully he's
      not blocking the dog that is fetching your morning newspaper, though.

      #URL<http://www.milter.org><Milters>
      are ... well, milters depend upon what type of underlying filter
      they use, as to what type of role they play in the metaphor. A spam
      assassin milter basically lets in all dogs, and then kicks them out as
      soon as it sees them squatting to poop in the yard. That may or may not
      be useful, and to a certain extent, the dog did get into your yard
      (wasting some of your CPU).

      A C-R system kicks the dog, so it goes back to its claimed home to bring
      back some form of proof about itself. Hopefully, the dog doesn't just
      run to the neighbor and bite him (as C-R systems are prone to causing),
      nor just choose to run away and get lost (due to being dropped or
      blocked by the original sender). And, of course, it does nothing to
      stop a poop-bearing dog that just happens to also have a pedigree
      certificate (a legit sender address that is willing and able to reply to
      the challenge, and is also a spammer).
      --John Rudd

2.0 A lightweight UBE block system with pure procmail

    2.1 Suitable for accounts which ...

        o   receive only a few messages a day: around max. 50.
        o   prefer simple and easy solution
        o   do not have much spare disk space (quota limits)
        o   have no possibilities to get or install new programs. System
            administrator doesn't have time or the mail server
            may be is running at separate server which is
            not to be modified.

        The value of 50 excludes all messages from mailing lists, because
        they can easily identified by procmail recipes. The remaining
        messages that slip through are those that need checking. If any of
        the above conditions are met, the "pure procmail only" solution may
        work. Picking any projects out there and installing it may well
        meet the expectations to stop Unsolicited Bulk Email. Some known
        procmail projects in this category include:

        o   Spambouncer <http://freshmeat.net/projects/spambouncer/>
        o   SPASTIC <http://freshmeat.net/projects/spastic/>,
        o   Procmail module library <http://pm-lib.sf.net>

        The instructions given here apply only to features found from
        modules in Procmail module library (pm-lib), which this document
        is part of but you're encourages to evaluate other to test what
        is best for your needs.

    2.2 Where to put "pure procmail" UBE checks?

        Where you put Unsolicited Bulk Email handling lines in your
        `~/.procmailrc' is extremely import for all *rule* *based*
        solutions.

                # ~/.procmailrc

                <define variables>
                <detect mailing lists and save messages>
                <detect work email and save messages>
                <detect other important messages: cron, daemon etc.>
                ... whatever you can reliable check
                <write message to backup.mbox at this point>
                <what's left is supect. PUT RULE BASED SPAM FILTER CALLS HERE>

                # End of file

        Why are the UBE rules put towards the end? Because rule based
        filters will make mistakes and classify valid messages as
        Unsolicited Bulk Email. There is nothing that can be done to
        this fact of life. The more messages they handle the more
        mistakes they do. The less messages they receive the less
        mistakes they do. That's why the goal is to detect as many
        messages as possible at the beginning and file them to
        appropriate folders. The chance of of losing important mail
        decreases if the rule based UBE solutions are near the bottom.

        Did you notice a small detail above? There is a reference to
        `backup.mbox' whose use is strongly encouraged for the first
        few weeks or months during fine tuning of recipes. Resist
        temptation to send detected UBE messages to `/dev/null' for
        long enough period until the recipes stabilize. Cautious
        persons never use `/dev/null' with rule based solutions
        because some important messages may have been misclassified.
        After gaining experience, some messages can be sent to
        `/dev/null'. Like the real positives where message includes
        a `*.exe' attachment, invalid character sets (Chinese,
        Korean) etc.

    2.3 Using Procmail Module Library to fight spam

        Ok, enough theory. Here is the section to be added near the bottom
        of `~/.procmailrc' file. Make sure the variable `PMSRC' points
        to directory where libraries modules are located as described
        in the INSTALL file.

            enabled = "yes"     # Set to "no" to disable this whole block

            :0
            * enabled ?? "yes"
            {
                saved   = $VERBOSE  # Do not record this to logs
                VERBOSE = "off"

                    JA_UBE_ATTACHMENT_ILLEGAL_KILL = "yes"
                    JA_UBE_VALID_ADDR = "(me@example.com|another@example.com)"
                    INCLUDERC         = $PMSRC/pm-jaube.rc

                    #  If ERROR is empty, it means the previous module
                    #  did not see anything special. Try another
                    #  spam detection module: search bad keywords

                    :0
                    * ERROR ?? ^^^^
                    {
                        INCLUDERC = $PMSRC/pm-jaube-keywords.rc
                    }

                VERBOSE = $saved

                #   If ERROR was set, the message was classified as UBE.
                #   The "\/" records reason to Procmail's log file

                :0 :
                * ERROR ?? ()\/.+
                spam.mbox
            }

3.0 A heavyweight UBE blocking system

        If you have the resources to install programs (or get them
        installed), you're doing the best service to yourself. After
        this section is put to action, any account will practically be
        a UBE free zone. Few statistical programs are needed to
        analyze incoming messages. They work like binary: either they
        classify message in category A (usually the "good") or in
        category B (the "bad"). There are a few exceptions like
        *ifile* which can be used for classifying messages into many
        categories. The catch here is that these programs need time to
        set up. Their effectiveness is directly dependent on patience
        spent on training. Without a good training they may be no
        better than average rule based solutions. An excellent article
        2003-08-23 on the subject is at
        <http://freshmeat.net/articles/view/964/> titled *Spam*
        *Filters* by Sam Holden.

        Due to different algorithms used in various programs, there is
        no single program that would be a universal UBE filter. Therefore
        the best strategy is to combine several programs in chain. If
        one classifies a message as "good" or "unsure" it can be sent
        to another program which may have another opinion. The
        installation of these programs is not teached here, because it
        is assumed that you have the needed expertise and knowledge
        already if you plan to jump into "heavyweight" UBE protection.

    3.1 Advice for Debian Exim 4 mail system administrator

        Before introducing end user means to prevent Unsolicited bulk
        email with procmail, a few words to a system administrator who
        is in charge of the local Mail Transport Agent aka the mail
        server. The advice given here is for *Debian* *Exim* *4* only,
        so google (that's a verb) few pages in the Net to find
        integration instructions to other mail servers. There is no
        other place in the system that can as effectively protect
        against Unsolicited Bulk Email as the mail transport layer;
        the beating MTA.

        #PIC pic/mta-ube.png # Mail Transport Agent (Exim, Sendmail, Postfix, Qmail etc.) include ways to check the message at SMTP RCPT time. E.g Exim includes ACL lists (1-3) which can check for incorrect SMTP sequences like trying to send DATA before HELO/missing HELO; forged HELO/reverse-dns combinations; to check sender against locally blocked domains; to check invalid characters in sender's email address etc. There are several possibilities. After these "fast" checks (4) external networks can be consulted. This could include checking IP against known block lists. If IP x.x.x.x is using a dynamic address space, the message is rejected immediately. Other checks may include comparing the message content against checksums (e.g. DCC service). If a match was found it would indicate that same message is being circulated. In addition to these the mail server may (5) call external processes to evaluate the message further with virus scanners and other analysis programs. The net result from any of these checks is to (6) make decision whether message is blocked or accepted. The SMTP connection is still open while all these checks are being run. Instead of reject code 5xx some mail server administrators may have even arranged to use 'teergrube' technique to hold the mail connection open for a long enough time in order to arrange a "tar pit" for the abuser.  ###

        o   install Exim 4, it's superior to Exim 3, because v4 can
            use ACL and other hooks before message is ever accepted.
            In Debian there are several Exim 4 packages, so make sure
            you use _apt-get_ _install_ _exim4-daemon-heavy_. The
            light version does not contain extended features. During
            the installation select *split* configuration files
            -- in the long run it will pay off. Also read
            `update-exim4.conf(8)' manual page after installation.
            After changing configuration, restart exim with
            _invoke-rc.d_ _exim4_ _restart_ (or use "reload").
        o   The easy part: install Debian package *sa-exim*
            (Spamassassin integrated to Exim 4's RCPT) and enable it from
            `/etc/exim4/sa-exim.conf' by setting `SAEximRunCond:1'.
            With few tweaks with the threshold values it can alone
            make 70 % of the UBE disappear from the system. The spam
            messages are blocked and those that are accepted, contain
            headers, which can be easily checked by user:

            #t2html::td:class=color-white:table:cellpadding=0

            X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on example.com
            X-Spam-Status: Yes, hits=10.0 required=9.0 tests=AWL,BAYES_99,
                BLANK_LINES_70_80,CLICK_BELOW,MSGID_SPAM_CAPS,REMOVE_PAGE
                autolearn=no version=2.64

        o   Install Debian package *greylistd*. It has to be
            configured manually for Exim4 (as of 2004-08-21). Read and
            follow instructions in directory
            `/usr/share/doc/greylistd'. After greylistd is running and
            integrated to Exim, _all_ messages are temporarily bounced
            back. This works because well behaving a mail servers will
            return them back. In the second time they will be
            accepted. The message have turned from grey to white, so
            to speak. Rapid spammers usually will not sit there
            waiting to resend the same messages, so the system is
            saved from many invalid messages.

        o   The above solutions most likely gives 80-90 % shield against UBE.
            If you are hosting a large user base or receive even higher
            volume of corporate mail, that may not be enough. Have a look
            at method called #URL<http://spf.pobox.com><SPF>
            which is based on published DNS records.
            Microsoft's has proposed
            #URL<http://lwn.net/Articles/101378/><competing>
            #URL<http://www.apache.org/foundation/docs/sender-id-position.html><Sender Id proposal>. Sender Policy Framework
            is directed at domain owners to encourage them to publish
            lists of servers that are permitted
            to originate email for the domain. SPF support is easily
            added to Exim. The instructions can be round from
            section titled
            #URL<http://slett.net/spam-filtering-for-mx/exim-spf.html><"A.7. Adding SPF Checks">.
            If separate Exim 4 SPF setup looks difficult, you can
            use spamassassin's built-in SPF support. See O'Reilly's
            article 2004-09-09
            #URL<http://www.onlamp.com/pub/a/onlamp/2004/09/09/spamassassin.html><What's New in SpamAssassin 3.0> by Alan Schwartz.

        #PIC pic/spf-system.png # Sender Policy Framework utilizes existing Domain Name Service TXT record feature. The TXT record publishes Mail Exhangers (MXs) or routes through which domain's mail must be sent. Any attemp to circumvent this route will get caught. Here the intruder tries (1) to send message to to.com by pretending to send message in behalf of from.com. The mail server that receives the incoming SMTP connection stalls the transaction while (2) performing a SPF query to read remote site's DNS record to verify if sender is using valid MX routing. (3) Results were negative. This sender pretended to be someone else as indicated by SPF query result and the (4) SMTP connection terminates at source with a reject code. Message was returned to the sender. ###

        Speaking of SPF it is worth to mention that it is not a method
        designed to prevent spam, but make the mail transportation
        route more transparent so that it cannot be that easily
        abused. SPF will stop messages which uses certain forms of
        address forgery. This is good for the targeted systems, and
        also good for the domains whose names are being forged into
        spam. SPF will not, by itself, stop spam which uses the
        spammer's own domain name. It's part of the methods that help
        force spammers to operate in even more tighter space in the
        Internet as discussed in comp.mail.misc
        #URL<http://groups.google.com/groups?threadm=MPG.1bbe551c75a3b3c8989a2a%40news1.news.adelphia.net><thread> 2004-09-24. Catching spammers is like
        cat and mouse game:

      The mouse now has to run a little further and harder to get to the
      mouse hole in the wall. There's a little more cost to acquiring that
      cheese. After you do that enough, the mouse says, it's not worth the
      effort unless it's a big chunk of cheese. What it boils down to is
      similar to the premise security system phenomenon. If a burglar sees
      a security system sign in front of a house, unless they're after
      something really special to them, they'll go to the next neighbor and
      the first guy on the street that doesn't have a sign is the one that
      gets burgled. --Murray Watson

        Further reading for system administrators:

        o   *Greylisting* - The Next Step in the Spam Control War by
            Evan Harris
            <http://projects.puremagic.com/greylisting/>.
        o   *Spam* *Filtering* *for* *Mail* *Exchangers* by Tor Slettnes.
            Pour high-octane fuel for Exim from this page
            at <http://slett.net/spam-filtering-for-mx/>.
        o   *Teergrubing* *FAQ*
            http://www.iks-jena.de/mitarb/lutz/usenet/teergrube.en.html
        o   "Explanations 3: Theory of numeric ``Status:'' codes"
            in Z-mailer's manual presents good overview of mail server's
            return codes at http://www.zmailer.org/reports-en.html
        o   *DSPAM*. Beyond the statistical filters.
            http://www.nuclearelephant.com/projects/dspam/

        Other opinions:

        o   Why you shouldn't jump on the SPF bandwagon
            http://david.woodhou.se/why-not-spf.html

    3.2 Advice for the normal account

            Note: Save classified message directories or mailboxes
            until you reach about 1000 messages in every category.
            After that it is safe to turn on *auto* *learn* options in
            presented programs. _Warning:_ in training, do not use
            messages that are over 6 months old because programs may
            think that old time stamps are indication of spam.

        You know how to compile programs or you run a distribution for
        which you can get presented packages easily. You have the disk
        space and you have the time (reserve a week) to hand sort your
        mailbox to individual messages. If you do not have the
        patience, it would be better if you never tried the Bayesian
        programs, because their accuracy depends on the quality of a
        comprehensive message base. Patience pays and the results are
        well worth it. Below are few programs that are supported by
        Procmail Module Library. You do not need all these programs,
        but the best results can be achieved only if you add more of
        them to the the message recognition chain.

        o   *Bogofilter.* Well known and actively developed.
            http://freshmeat.net/projects/bogofilter
        o   *Bayesian* *Mail* *Filter.* Very, very accurate, while
            development activity is unknown.
            http://freshmeat.net/projects/bmf
        o   *Spamprobe.* Another very accurate Bayesian program.
            http://freshmeat.net/projects/spamprobe
        o   *Ifile.* Yet another classification program, but this one
            can be trained to detect different classes of messages.
            Instead of two category separation into spam and ham, this
            program can be trained for any number of messages type:
            spam, ham, daemon, virus, bugs, work etc. Ifile is not
            well suited for pure spam, ham separation, because it
            does not detect HTML or MIME. The project page is at
            <http://freshmeat.net/projects/ifile> and low volume
            discussion list at
            <http://lists.gnu.org/archive/html/ifile-discuss>
        o   *Annoyance* *filter* . Development
            activity is unknown.
            http://sourceforge.net/projects/annoyancefilter/
        o   *Bsfilter* Ruby based Japanese aware filter. Development
            activity is unknown.
            http://freshmeat.net/projects/bsfilter
        o   *Spamoracle* OCaml based bayesian filtering. Development
            activity is unknown.
            http://freshmeat.net/projects/spamoracle

        Other program that might be of interest:

        o   *Spamassassin.* This a bit difficult is you do not know
            Perl and how to install Perl modules privately.
            http://www.spamassassin.org/
        o   *Spambayes.* Python based solution. Like bogofilter it
            classifies messages into categories spam, ham and unsure.
            http://spambayes.sourceforge.net/
        o   *Popfile*. There is one unique feature in this program. It
            can act as a IMAP client and watch each IMAP folder. It
            knows if things are movew. Thus, when message is moved out
            of Spam folder into your Ham folder, it learns that it
            made a mistake (and vice versa).
            http://sourceforge.net/projects/popfile/
        o   *A* *digramic* *Bayesian* *classifier*.
            http://sourceforge.net/projects/dbacl
        o   *Controllable* *Regex* *Mutilator* Python based solution.
            A complete programming language, which can be used for
            spam filtering as well.
            http://crm114.sf.net/
        o   *MailWasher* server-side spam filtering program.
            http://sourceforge.net/projects/mailwasher

        Examine mailboxes and manually sort your messages to at least
        three categories: *good*, *bad*, *other*. The "other" category
        includes auto responder messages e.g. from mail servers who
        return undeliverable email and report other transport errors.
        It can also include cron job and other automatically generated
        messages like virus indication bounces that badly informed
        sites send. The minimum count of messages in each folder is
        somewhere 200. The more the better and with 1000 messages the
        reliability is pretty good. It is also known that inserting
        messages more than twice or three times can actually decrease
        precision.

        The rule of thumb is that the ratio between good/bad should be
        kept somewhere 30:70 meaning that if the total count of
        messages is 1000, there must be at minimum of 300 (30%) good
        messages and 700 (70%) bad messages. If more messages are
        added to the bad category -- say in ratio shifts to 10:90 --
        the used Bayesian filter will skew and will eventually start
        classifying messages in wrong category. It is said that the
        Bayesian works best if it is kept balanced 50:50, but there
        are indications that better results can be achieved with ratio
        40:60 (good/bad). Can't point you to any specific pages that
        would back up that claim though. Some programs may work better
        50:50 and some with 30:70, so 40:70 seems to be a safe bet.

            Note: the following instructions are for "one message per file"
            format (a la MH). If you have stored messages in standard
            Berkeley styled mailbox (.mbox) format, please examine the
            manual pages for correct options.

        To train _bogofilter:_ (C language)

            $ rm -f ~/.bogofilter/*.db
            $ bogofilter -B -n good.msg ...
            $ bogofilter -B -s spam.msg ...

        To train _Bayesian_ _Mail_ _filter:_ (C language)

            $ rm -f ~/.bmf/*db*
            $ ls good/*.msg | xargs -n 1 bmf -n    # feed individual messages
            $ ls spam/*.msg | xargs -n 1 bmf -s    # feed individual messages

        To train _spamprobe:_ (C++ language)

            $ rm -f ~/.spamprobe/*
            $ spamprobe -8 good good.msg ...
            $ spamprobe -8 spam spam.msg ...

        To train _annoyance_ _filter:_ (C++ language)

            $ mkdir ~/.annoyance
            $ rm -f ~/.annoyance/*.bin
            $ DB=$HOME/.annoyance/dict.bin; DB2=$HOME/.annoyance/fdict.bin
            $ annoyance-filter --mail single.msg --prune --write $DB # INIT
            $ annoyance-filter --phrasemax 2 \
              --read  $DB  \
              --mail dir/to/good/messages \
              --junk dir/to/bad/messages \
              --prune --write $DB
            $ annoyance-filter -v --read $DB --prune --fwrite $DB2

        To train _spamoracle:_ (OCaml language)

            $ rm -f ~/.spamoracle.db
            $ spamoracle add -v -good good.msg ...
            $ spamoracle add -v -spam spam.msg ...

        To train _bsfilter:_ (Ruby language)

            $ rm -f ~/.bsfilter/*.{dir,pag,lock}
            $ bsfilter --add-clean good.msg ...
            $ bsfilter --add-spam  spam.msg ...

        To train _spamassassin:_ (Perl language)

            $ rm -f ~/.spamassassin/bayes*
            $ sa-learn --local --no-sync --ham  good.msg ...
            $ sa-learn --local --no-sync --spam spam.msg ...
            $ sa-learn --sync

        To train _ifile:_ it is a little different. You can train it
        to use detect any category. The third directory *other* where
        you were asked to save the daemon messages previously is used
        for this purpose. Here it is trained with the *other* mailbox
        in addition to standard spam and good messages. Other viable
        training categories could include virus, bug (reports and
        answers) and work. Just sort messages in finer categories and
        repeat the procedure.

            $ rm ~/.idata
            $ echo herbalife | ifile --insert=spam    # initialize database
            $ ifile --reset-data                      # OR use this
            $ ifile --strip-header --insert=good   good.msg ...
            $ ifile --strip-header --insert=spam   spam.msg ...
            $ ifile --strip-header --insert=daemon daemon.msg ...

        The strategy to improve these programs after first 200+200
        (good/bad) messages is to put them in action and examine what
        messages slip through. Collect all unfiltered messages and add them
        to existing `~/tmp/mail/train/{good,bad,other}/' directories or
        mailboxes. After few weeks some the logs may show 10-100 new unsure
        or misclassified message. Add these to to the _pristine_ training
        directories. When it's time to refresh the databases with the newly
        added messages, it is important to start from fresh. _Delete_ all
        programs' databases, as shown by the `rm' commands above, and
        repeat the training procedures.

        Many of the Bayesian programs have options or commands to put
        them in *auto* *learn* mode while called from `~/.procmailrc',
        but it should not be used at start. Only when the programs
        have been trained with a sufficient message base of (best
        1000+1000 good/bad), the auto learn option could be
        considered. The motivation is that using auto learn is
        dangerous. If auto learn is tuned on when initial message base
        small, the programs will eventually classify messages into
        wrong categories and in time "learn" option will cause the
        statistics to skew bit by bit. The reliability of the filter
        will suffer and confidence to detect "real" Unsolicited Bulk
        Email will decrease. So be patient and _collect_ _enough_
        _messages_ and hand train each program.

    3.3 Configuring  Bayesian programs

        Most of the programs do not need any special configuration,
        but some do. With Bayesian programs, if strict bounds are used
        to classify messages into good/bad categories, message back
        ups can mostly be forgotten. A well trained filters usually
        don't make mistakes and messages can be sent to `/dev/null'. A
        UBE probability value for a good message is typically _0.1_
        and _0.9_ for bad messages. For Spamassassin the values are
        different; a good initial setting to discriminate good/bad bar
        is between 5-10 (safe) and 3-5 (probably safe).

            # ~/.spamassassin/user_prefs

            required_hits                    3.0       # Default was 5.00
            bayes_auto_learn                 1
            bayes_auto_learn_threshold_spam  9.0       # Default was 12.0
            report_safe                      0
            ok_languages                     en

            #  headers may provide inappropriate cues to the
            #  Bayesian classifiers

            bayes_ignore_header X-Bogosity
            bayes_ignore_header X-Spam-Status
            bayes_ignore_header X-Spam-Flag
            bayes_ignore_header X-Spam-Annoyance-Status
            bayes_ignore_header X-Spam-Annoyance-Classification
            bayes_ignore_header X-Spam-Annoyance-Probability
            bayes_ignore_header X-Spam-Bogofilter-Status
            bayes_ignore_header X-Spam-Bmf-Flag
            bayes_ignore_header X-Spam-Bmf-Status
            bayes_ignore_header X-Spam-Bsfilter-Flag
            bayes_ignore_header X-Spam-Bsfilter-Status
            bayes_ignore_header X-Spam-Bsfilter-Version
            bayes_ignore_header X-Spam-Ifile-Status
            bayes_ignore_header X-Spam-Spamoracle-Status
            bayes_ignore_header X-Spam-Spamoracle-Score
            bayes_ignore_header X-Spam-Spamoracle-Details
            bayes_ignore_header X-Spam-Spamoracle-Attachments
            bayes_ignore_header X-Spam-Spamprobe-Status
            bayes_ignore_header X-Spam-Jaube
            bayes_ignore_header X-Spam-JaubeKwd

            # End of file

        For the `~/.bogofilter.cf' you would need these values uncommented:

            ham_cutoff  = 0.2       # or 0.1 if you have well trained database
            spam_cutoff = 0.9

    3.4 A heavyweight spam catch setup using procmail

        #PIC pic/procmail-bayesian.png # Procmail can process and examine mail only with regular expression rules. E.g. it is possible to write a static rule that matches "viagra" and file message to spam mailbox. But the possibilities are too many for any static rule based content checking and thus statistical analysis yields better results for mutable messages. Each statictical - usually "Bayesian" - program use slightly different algorithms to detect Unsolicited Bulk email. Therefore consulting many statistical programs makes a better shield than using a single program. ###

        Several interface modules to various Bayesian programs have
        been included in the Procmail Module Library. To make using
        those modules easier, there is one umbrella module
        *pma-jaube-prg-runall.rc* which will take care of the details.
        What's left to do, is to define what programs are available in
        the system and which have been trained. The umbrella module
        tries every defined program one by one until some of them
        thinks the message is Spam. Bogofilter is a special case,
        because it returns value "unsure" if message is somewhere
        between spam and ham.

            SHELL       = /bin/sh
            PMSRC       = $HOME/procmail/pm-lib/lib
            INCLUDERC   = $PMSRC/pm-javar.rc    # Define variables

            #   If you do not have one of these programs installed,
            #   simply *comment* *out* the line and it will
            #   automatically disable any recipes using it.
            #
            #   For spamassassin daemon version, use "spamc"

            JA_UBE_ANNOYANCE_PRG    = "/usr/bin/annoyance-filter"
            JA_UBE_BMF_PRG          = "/usr/bin/bmf" # Bayesian Mail Filter
            JA_UBE_BSFILTER_PRG     = "/usr/bin/bsfilter"
            JA_UBE_BOGOFILTER_PRG   = "/usr/bin/bogofilter"
            JA_UBE_IFILE_PRG        = "/usr/bin/ifile"
            JA_UBE_SPAMASSASSIN_PRG = "/usr/bin/spamassassin"
            JA_UBE_SPAMORACLE_PRG   = "/usr/bin/spamoracle"
            JA_UBE_SPAMPROBE_PRG    = "/usr/bin/spamprobe"

            # ... filter mailing lists, etc. HERE, before spam detection ...

            #  This module is "umbrella" for all Bayesian programs.
            #  Variable ERROR is set if any of the programs classified
            #  the message as spam.

            INCLUDERC = $PMSRC/pm-jaube-prg-runall.rc

            :0 :
            * ERROR ?? ^()\/.+
            spam.mbox

            #   ifile is special. It can be trained to detect several kinds
            #   of messages.

            INCLUDERC = $PMSRC/pm-jaube-prg-ifile.rc

            :0 :
            * ERROR ?? \/[a-z]+
            $MATCH.mbox

        This setup may be best suitable for a accounts that receive high
        volume of mail Unsolicited Bulk Email. Keep in mind that any Perl,
        Python, Ruby and other high-level language solution does not suit
        well for heavy mail handling. These interpreters' initial startup
        time is costly for both CPU and memory. Firing up such programs in
        rapid succession for many small messages causes strain to system
        resources. If CPU consumption must be considered for the overall
        server performance, disabling all calls to Perl and Python based
        spam solutions could improve server's performance. Concentrating on
        solely on natively compiled programs helps to squeeze speed out
        procmail recipes. The less external calls are there, the faster and
        more system friendly the procmail setup is.

End

